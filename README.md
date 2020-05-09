# Shiny Dashboards
shinydashboard (v0.1) mainly uses CSS from the [AdminLTE template](https://adminlte.io/themes/AdminLTE/documentation/index.html) which is built around [Bootstrap v3](https://getbootstrap.com/docs/3.4/)

## User Interface
A shiny dashboard UI consists of a header, sidebar and body:
```r
ui_header <- dashboardHeader()
ui_sidebar <- dashboardSidebar()
ui_body <- dashboardBody()
ui <- dashboardPage(ui_header, ui_sidebar, ui_body)
```
Most shiny functions generate html code:  
**dashboardHeader()** generates:
```html
<header class="main-header">
  <span class="logo"></span>
  <nav class="navbar navbar-static-top" role="navigation">
    <span style="display:none;">
      <i class="fa fa-bars"></i>
    </span>
    <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
      <span class="sr-only">Toggle navigation</span>
    </a>
    <div class="navbar-custom-menu">
      <ul class="nav navbar-nav"></ul>
    </div>
  </nav>
</header>
```
**dashboardSidebar()** generates:
```html
<aside id="sidebarCollapsed" class="main-sidebar" data-collapsed="false">
  <section id="sidebarItemExpanded" class="sidebar"></section>
</aside>
```
**dashboardBody()**
```html
<div class="content-wrapper">
  <section class="content"></section>
</div> generates:
```
**dashboardPage()** wraps the components:
```html
<body class="skin-blue" style="min-height: 611px;">	
  <div class="wrapper">
    <!-- header/sidebar/body code -->  
  </div>	
</body>    
```

## dashboardHeader()
The function has arguments dashboardHeader(title = "Custom Title", disable=TRUE) these amend the basic html, eg.:
```html
<header class="main-header" style="display: none;">
  <span class="logo">Custom Title</span>
  ...
```

## dashboardSidebar()
A sidebar will normally contain a menu. The basic R code for this is involves nesting other functions:
```r
dashboardSidebar(
  sidebarMenu(
    id = "sidebar_menu",
    menuItem("Page1", tabName = "item1"),
    menuItem("Page2", tabName = "item2"),
    menuItem("Page3", tabName = "item3"),
    menuItem("Page4", tabName = "item4")
 )
)
```
sidebarMenu() creates a empty html list <ul> and the menuItem() add elements <li> to it. E.g: 
```html
<ul class="sidebar-menu">
  <li>
    <a href="#shiny-tab-item1" data-toggle="tab" data-value="item1">
      <span>Page1</span>
    </a>
  </li>
  <li>
    <a href="#shiny-tab-item2" data-toggle="tab" data-value="item2">
      <span>Page2</span>
    </a>
  </li>
  <div id="sidebar_menu" class="sidebarMenuSelectedTabItem" data-value="null"></div>
</ul>
```


  
## dashboardBody()
If your dashbaorad has multiple tabs the the basic dashbaoard body strcuture will look like:
```r
tabItems(tabItem(tabName = "item1"),
         tabItem(tabName = "item2"))
# tabNames those used when creating the sidebar
```
In html this geneartes:
```html
<div class="tab-content">
  <div role="tabpanel" class="tab-pane" id="shiny-tab-item1"></div>
  <div role="tabpanel" class="tab-pane" id="shiny-tab-item2"></div>
</div>
```
Within each tab, the content are displayed using fluidrows and boxes:
```r
tabItem(
  tabName = "item1",
  fluidRow(
    box(width = 6,
        solidHeader = TRUE,
        status = "primary"
        # Text or Outputs here
    ),     
    box(width = 6,
        solidHeader = TRUE,
        status = "primary",
        title = "Time Series"
        # Text or Outputs here
    )
  ),
  fluidRow(
    box(width = 12)
    # Text or Outputs here
  ) 
)
```
Each fluidRow() creates a <div class="row">. Each box() genartes another <div> that uses the bootstrap grid system to determine its width. It may also generate further nested <div> for box title headers and body content.  
```html
<div role="tabpanel" class="tab-pane" id="shiny-tab-item1">
  
  <div class="row">
    <div class="col-sm-6">
      <div class="box box-solid box-primary">
        <div class="box-body"></div>
      </div>
    </div>
    <div class="col-sm-6">
      <div class="box box-solid box-primary">
        <div class="box-header">
          <h3 class="box-title">Dygraph Time Series</h3>
        </div>
        <div class="box-body"></div>
      </div>
    </div>
  </div>
  
  <div class="row">
    <div class="col-sm-12">
      <div class="box">
        <div class="box-body"></div>
      </div>
    </div>
  </div>

</div>
```


## User inputs
User input boxes may appear in the dashboard sidebar or body. Eg:
```r
selectInput(inputId = "select",
            "Preset dates", 
            choices=c("France","Germany","USA","China","Japan"), 
            selected="")
```
Generates a html <div> containing a <select> element:
```html
<div class="form-group shiny-input-container">
  <label class="control-label" for="select">Preset dates</label>
  <div>
    <select id="select">
      <option value="France">France</option>
      <option value="Germany">Germany</option>
      <option value="USA">USA</option>
      <option value="China">China</option>
      <option value="Japan">Japan</option></select>
    <script type="application/json" data-for="select" data-nonempty="">{}</script>
  </div>
</div>
```
In R selectInput() uses **selectize.js** by default (hence the addition of the <script> line). R keeps track of any extra javascript libraries that are used and adds them to the <head>.

```r
dateRangeInput(inputId = "date_range",
               "Date range:",
               start= "2019-01-01",
               end = "2019-03-31",
               format = "dd-M-yyyy",
               separator = " to ")
```
Generates a html <div> containing a date <input> element:
```html
<div id="date_range" class="shiny-date-range-input form-group shiny-input-container">
  <label class="control-label" for="date_range">Date range:</label>
  <div class="input-daterange input-group">
    <input class="input-sm form-control" type="text" data-date-language="en" data-date-week-start="0" data-date-format="dd-M-yyyy" data-date-start-view="month" data-initial-date="2019-01-01" data-date-autoclose="true"/>
    <span class="input-group-addon"> to </span>
    <input class="input-sm form-control" type="text" data-date-language="en" data-date-week-start="0" data-date-format="dd-M-yyyy" data-date-start-view="month" data-initial-date="2019-03-31" data-date-autoclose="true"/>
  </div>
</div>
```
