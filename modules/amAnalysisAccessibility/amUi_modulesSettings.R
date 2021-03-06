wellPanel(
  amCenterTitle(div(icon("wrench"),"Analysis settings"),h=3,m=0,sub="Configure parameters for this analysis."),
  #
  # Settings anisotropic
  #
  conditionalPanel(condition="
    input.moduleSelector=='module_2' | 
      input.moduleSelector=='module_3' |
      input.moduleSelector=='module_4' |
      input.moduleSelector=='module_6'
    ",
    conditionalPanel(condition="input.moduleSelector=='module_6'",
      #
      #  Choice of start layer
      #
      radioButtons("useExistingHf",
        label=paste("Options for the output layer ",names(config$dynamicFacilities)),
        choices=c("Start with empty layer"=FALSE,"Start using selected existing facilities"=TRUE),
        selected=TRUE
        ),
      #
      # Additional text
      #
      amCenterTitle(title="Parameters for new facilities evaluation",h=4)
      ),
    #
    # General accessibility analysis setting
    #
    radioButtons("typeAnalysis","Type of analysis",
      c("Isotropic (ignore DEM)"="isotropic",
        "Anisotropic (use DEM)"="anisotropic"
        ),
      selected="anisotropic",
      inline=FALSE
      ),
    conditionalPanel(
      condition="
      input.typeAnalysis=='anisotropic' & (
        input.moduleSelector=='module_2' | 
          input.moduleSelector=='module_3' |
          input.moduleSelector=='module_6'
        ) ",
      radioButtons('dirAnalysis','Direction of travel',
        c(
          "From facilities"="fromHf",
          "Towards facilities"="toHf"),
        selected='toHf',
        inline=FALSE
        )
      )
    ),
  #
  # Module 3: sorting parameters
  #
  conditionalPanel(condition="input.moduleSelector=='module_3'",
    radioButtons("hfOrder","Facilities processing order according to:",
      c(
        "A field in the health facility layer"="tableOrder",
        "The population living within a given travel time from the facilities"="travelTime",
        "The population living within a circular buffer around the facilities"="circBuffer"
        )
      ), 
    #  conditionalPanel( condition="input.hfOrder!="tableOrder"",
    conditionalPanel(condition="input.hfOrder=='tableOrder' && isNotEmpty(input.hfSelect)",
      selectInput("hfOrderColumn","Select field from the facility layer",choices="")
      ),
    conditionalPanel( condition="input.hfOrder=='circBuffer'",
      numericInput("popBufferRadius","Buffer radius [meters] ",value=5000)
      ),
    conditionalPanel(condition="input.hfOrder=='travelTime'",
      numericInput("maxTravelTimeProcOrder",
        label="Given travel time [minutes]",
        value=120,
        min=0,
        max=1080,# note: max value un raster cell for geotiff with color palette (unint16) :2^16-1
        step=1
        )
      ),
    radioButtons("hfOrderSorting","Processing order:",
      c(
        "Ascending"="hfOrderAsc",
        "Descending"="hfOrderDesc"
        ),
      selected="hfOrderDesc",
      inline=FALSE
      )
    ),
  #
  # Referral options
  #
  conditionalPanel(condition="input.moduleSelector=='module_4'",
    checkboxInput(
      label="Limit the distance analysis to the closest destination point in time",
      inputId="checkReferralLimitClosest",
      value=TRUE
      )
    ),
  #
  # Set maximum walk time
  #
  conditionalPanel(condition="(
    input.moduleSelector=='module_2' | 
      input.moduleSelector=='module_3' |
      input.moduleSelector=='module_4' |
      input.moduleSelector=='module_6'
    )",
  numericInput("maxTravelTime",
    label="Maximum travel time [minutes]",
    value=120,
    min=0,
    max=40*24*60,# note: max value un raster cell for geotiff with color palette (unint16) :2^16-1. Set to max 40 day.
    step=1
    ),
  #
  #  Scaling up  
  #
  conditionalPanel(condition="input.moduleSelector=='module_6'",
    tagList(
      amCenterTitle(
        title=div("Computation limits",
          actionLink(
            inputId='helpLinkComputeLimit',
            icon=icon('question-circle'),
            label=''
            )
          ),
        h=4),
      div(
        numericInput('maxScUpPopGoal',
          label='Percentage of population to cover [%]',
          value=80,
          min=0,
          max=100
          ),
        numericInput('maxScUpNewHf',
          label='Number of new health facilities to locate [facility]',
          value=0,
          min=0,
          max=500,
          step=1
          ),
        numericInput('maxScUpTime',
          label='Maximum processing time [minutes]',
          value=0,
          min=0,
          max=400
          )
        )
      )
    )
  ),
#
# Module 3 and 6 more options
#
conditionalPanel(condition="(
  input.moduleSelector=='module_3'|
    input.moduleSelector=='modue_6'
  )",
checkboxGroupInput("mod3param","Options:",choices=list(
    "Compute catchment area layer."="vectCatch",
    "Remove the covered population at each iteration."="rmPop",
    "Compute map of population cells on barriers."="popBarrier", 
    "Generate zonal statistics (select zones layer in data input section)"="zonalPop"
    ),selected=c("rmPop","vectCatch","popBarrier"))
),
conditionalPanel(condition="(
  input.moduleSelector!='module_5'
  )",
textInput('costTag','Add short tags',value='')
)
)
