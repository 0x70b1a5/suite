::  inet/index: browse the library
::
::    (for the shocked bystander: yes, there's some ugly code here.
::     we are very much in "event running mode", not in "architecture mode".
::     if it works, it works!)
::
/-  *inet
/+  rudder, bbcode, *pal
::
^-  (page:rudder state action)
|_  [bowl:gall =order:rudder state]
++  argue
  |=  [headers=header-list:http body=(unit octs)]
  ^-  $@(brief:rudder action)
  ?~  body  ~
  =/  args=(map @t @t)
    (frisk:rudder q.u.body)
  ?:  (~(has by args) 'save')
    ?~  id=(biff (~(get by args) 'i') (curr rush dum:ag))  ~
    ?~  content=(~(get by args) 'content')  ~
    ?:  =('' u.content)  'Clippy has no time for your games.'
    =/  sprout=(unit @ud)
      %+  sink  (biff (~(get by args) 'p') (curr rush dum:ag))
      (bind (~(get by library) [our u.id]) |=(story sprout))
    ?~  sprout  'Clippy doesn\'t know where to save this to...'
    [%add u.id u.sprout now u.content]
  ?:  (~(has by args) 'show')
    [%pre ~]
  ?:  (~(has by args) 'nuke')
    ?~  id=(biff (~(get by args) 'i') (curr rush dum:ag))  ~
    [%del u.id]
  ?:  (~(has by args) 'like')
    ?~  at=(biff (~(get by args) 'a') (curr rush ;~(pfix sig fed:ag)))  ~
    ?~  id=(biff (~(get by args) 'i') (curr rush dum:ag))  ~
    [%luv [u.at u.id]]
  ~
::
::  +final: if we asked to preview content, do so
++  final
  |=  [done=? =brief:rudder]
  ^-  reply:rudder
  =/  args=(map @t @t)
    ?~  body.request.order  ~
    (frisk:rudder q.u.body.request.order)
  =/  show=(unit @t)
    ?~  body.request.order  ~
    ?.  (~(has by args) 'show')  ~
    (~(get by args) 'content')
  ::TODO  would honestly be really nice if the action was passed...
  ?:  &(done |((~(has by args) 'save') (~(has by args) 'like')))
    =;  url  [%next (crip url) brief]
    =;  who  "/invisible-networks?a={who}&i={(trip (~(got by args) 'i'))}"
    ?:((~(has by args) 'save') (scow %p our) (trip (~(got by args) 'a')))
  ?:  &(done (~(has by args) 'nuke'))
    [%next '/invisible-networks' brief]
  %+  build
    =-  ?~(show - ['content'^u.show -])
    args:(purse:rudder url.request.order)
  ?~(brief ~ `[| brief])
::
++  build
  |=  [args=(list [k=@t v=@t]) msg=(unit [? @t])]
  ^-  reply:rudder
  =/  day=@ud  ?:((gth start now) 0 (div (sub now start) ~d1))
  =/  sprouts  (scag +(day) sprouts)
  ::
  =/  args=(map @t @t)    (my `(list (pair @t @t))`args)
  =/  author=(unit @p)    (biff (~(get by args) 'a') (cury slaw %p))
  =/  id=(unit @)         (biff (~(get by args) 'i') (cury slaw %ud))
  =/  index=(unit index)  (both author id)
  =/  sprout=(unit @ud)   (biff (~(get by args) 'p') (cury slaw %ud))
  =/  alter=?             ?&  |(?=(^ sprout) ?=(^ index))
                              =(our (fall author our))
                              (~(has by args) 'e')
                          ==
  ::
  ~|  [index=index id=id author=author sprout=sprout alter=alter]
  =?  sprout  &(?=(^ sprout) !=(0 u.sprout))  `(dec u.sprout)
  =?  sprout  &(?=(^ sprout) (gte u.sprout (lent sprouts)))  ~
  ::  default to showing the "daily" prompt, rolling over after event ends
  ::
  =?  sprout  &(=(~ author) =(~ sprout))
    ?:  =(~ sprouts)  ~
    ?:  (gth start now)  ~
    `(mod day (lent sprouts))
  ::
  =/  format
    ?:  alter   %pencil
    ?^  index   %single
    ?^  sprout  %sprout
    ?^  author  %author
    %biding
  ~|  format=format
  |^  [%page page]
  ::
  ++  style
    '''
    /*

    WIN95.CSS
    https://github.com/AlexBSoft/win95.css
    Author: Alex B (alex-b.me)
    License: MIT

    Version: 1.2.0
    06.12.2020

    */
    html {
      position: relative;
      min-height: 100%;
    }
    /*

    Body styles

    */
    body {
        font-family: "MS Sans Serif",Tahoma,Verdana,Segoe,sans-serif; 
        /*background: teal;*/
        color: white;
        padding-bottom: 28px;
    }
    .bg-cloud{
        background-image: url('https://alexbsoft.github.io/win95.css/assets/clouds2.jpg');
        color:#212529;
    }

    /*

    Link color

    */
    a {
        color:#2d49eb;
    }

    /*

    Header

    */
    header {
      position: relative;
      background-color: black;
      height: 100vh;
      min-height: 25rem;
      width: 100%;
      overflow: hidden;
    }
    header video {
      position: absolute;
      top: 50%;
      left: 50%;
      min-width: 100%;
      min-height: 100%;
      width: auto;
      height: auto;
      z-index: 0;
      -ms-transform: translateX(-50%) translateY(-50%);
      -moz-transform: translateX(-50%) translateY(-50%);
      -webkit-transform: translateX(-50%) translateY(-50%);
      transform: translateX(-50%) translateY(-50%);
    }
    header .container {
      position: relative;
      z-index: 2;
    }
    /*

    Scrollbar (only chrome & safari)

    */
    ::-webkit-scrollbar {
      width: 12px;
    }
    ::-webkit-scrollbar-button:end:increment,::-webkit-scrollbar-button:start:decrement {
        display: block
    }
    ::-webkit-scrollbar-button:vertical:end:decrement,::-webkit-scrollbar-button:vertical:start:increment {
        display: none
    }
    ::-webkit-scrollbar-button:vertical:increment {
        width: 18px;
        background: silver url(combo.png) no-repeat 50%;
        height: 18px;
        margin: 1px 1px 1px 10px;
        -webkit-transform: rotateX(-90deg);
        transform: rotateX(-90deg);
        -webkit-transform: rotateY(-90deg);
        transform: rotateY(-90deg);
        border: 1px outset #fff;
        border-shadow: 1px 1px #000;
    }
    ::-webkit-scrollbar-button:vertical:decrement {
        width: 11px;
        background: silver url(comboup.png) no-repeat 50%;
        height: 16px;
        margin: 1px 1px 1px 10px;
        transform: rotateX(180deg);
        -webkit-transform: rotateY(180deg);
        border: 1px outset #fff;
        border-shadow: 1px 1px #000
    }
    ::-webkit-scrollbar-track{
        background-image: url(background.bmp)
    }
    ::-webkit-scrollbar-thumb:vertical {
        border: 1px outset #fff;
        border-shadow: 1px 1px #000;
        height: 40px;
        background-color: silver
    }
    ::-webkit-scrollbar-corner:vertical {
        background-color: #000
    }
    :-webkit-scrollbar-button:start:decrement,::-webkit-scrollbar-button:end:increment {
        display: block
    }
    ::-webkit-scrollbar-button:horizontal:end:decrement,::-webkit-scrollbar-button:horizontal:start:increment {
        display: none
    }
    ::-webkit-scrollbar-button:horizontal:increment {
        background: silver url(comboright.png) no-repeat 50%;
        -webkit-transform: rotateX(-90deg);
        transform: rotateX(-90deg);
        -webkit-transform: rotateY(-90deg);
        transform: rotateY(-90deg)
    }
    ::-webkit-scrollbar-button:horizontal:decrement,::-webkit-scrollbar-button:horizontal:increment {
        width: 18px;
        height: 18px;
        margin: 1px 1px 1px 10px;
        border: 1px outset #fff;
        border-shadow: 1px 1px #000
    }
    ::-webkit-scrollbar-button:horizontal:decrement {
        background: silver url(comboleft.png) no-repeat 50%;
        transform: rotateX(180deg);
        -webkit-transform: rotateY(180deg)
    }
    ::-webkit-scrollbar-track-piece {
        margin: 1px;
    }
    ::-webkit-scrollbar-thumb:horizontal {
        border: 1px outset #fff;
        border-shadow: 1px 1px #000;
        height: 40px;
        background-color: silver
    }

    /*

        Button styles

    */
    .btn{
        border-width: 2px;
        border-style: outset;
        border-color: buttonface;
        border-right-color: #424242;
        border-bottom-color: #424242;
        background: silver;
        color: black;
        padding: 0 0 4px;
        border-radius: 1px;
    }
    .btn:hover {
        border: 2px inset #fff;
        background: silver;
        color: #424242;
        box-shadow: -1px -1px #000;
    }
    .btn:focus {
        border: 2px inset #fff !important;
        background: silver;
        color: #424242;
        box-shadow: -1px -1px #000 !important;
        outline: 0 !important;
        background: url(background.bmp);
    }
    .btn:active {
        border: 2px inset #fff !important;
        color: #424242;
        box-shadow: -1px -1px #000 !important;
        outline: 0 !important;
        background: url(background.bmp);
    }

    .btn-primary{
        padding-left: 8px;
        padding-right: 8px;
    }
    button:focus{
        outline: 1px dotted;
    }
    .btn.disabled,.btn:disabled{
        cursor: default;
        background-color: silver;
        border-style: outset;
        border-color: buttonface;
        border-right-color: #424242;
        border-bottom-color: #424242;
        color: grey;
        text-shadow: 1px 1px #fff;
    }

    /*

    CARDS

    */

    .card {
      position: relative;
      display: flex;
      flex-direction: column;
      min-width: 0;
      word-wrap: break-word;
      background-clip: border-box;
    }
    .card-header {
      padding: 0.75rem 1.25rem;
      margin-bottom: 0;
    }
    .card-body {
      flex: 1 1 auto;
      display: flex;
      flex-direction: column;
      min-height: 1px;
      padding: 1.25rem;
    }

    .card{
        border: solid;
        border-width: 2px;
        border-bottom-color: #424242;
        border-right-color: #424242;
        border-left-color: #fff;
        border-top-color: #fff;
        background: silver;
        color:#212529;
    }
    .card.square{
        border-radius: 0px;
    }
    .card.square .card-header{
        border-radius: 0px;
    }
    .card.w95 .card-header{
        background: #08216b;
        /* OR #000082 is better?*/
    }
    .card-header{
        background: -webkit-linear-gradient(left,#08216b,#a5cef7);
        color: #fff;
        display: block;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        padding-top: 2px;
        padding-bottom: 1px;
        text-align: left;
    }
    .card-header.icon{
        padding-left: 4px;
    }
    .card-header h1, .card-header h2, .card-header h3, .card-header h4 {
      margin: 0;
    }
    .header-inactive{
        background: gray !important;
    }

    /*

    LIST GROUPS

    */
    .list-group{
        border: solid;
        border-width: 2px;
        border-bottom-color: #424242;
        border-right-color: #424242;
        border-left-color: #fff;
        border-top-color: #fff;
        background: silver;
        color:#212529;
    }
    .list-group-item{
        position: relative;
        display: block;
        background: transparent;
        color: #212529;
    }
    .list-group-item-primary{
        color: white;
        background: -webkit-linear-gradient(left,#08216b,#a5cef7);
    }
    .list-group-item-action:hover {
        color: #08216b;
    }

    /*

    NAVBAR

    */
    .navbar-95{
        background: silver;
        margin: 0;
        border: 1px outset #fff;
        padding: 0 6px;
        color:#212529;
    }

    .navbar-brand{
        color:#212529;
        padding: 0 6px;
    }
    .nav-link{
        text-decoration: none;
        display: inline-block;
        padding: 0 9px;
        color:#212529;
        font-size: 0.9em;
    }
    .dropdown-menu{
        display: none;
        min-width: 119px;
        padding: 0 0 2px;
        margin-left: 12px;
        font-size: 12px;
        list-style-type: none;
        background: silver;
        border: 1.8px outset #fff;
        border-radius: 0;
        -webkit-box-shadow: 1.5px 1.5px #000;
        box-shadow: 1.5px 1.5px #000;
    }
    .dropdown-item{
        padding: 1px 0 1px 2px;
    }
    .dropdown-item:hover{
        color:#08216b;
    }
    .navbar-light .navbar-toggler.collapsed .navbar-toggler-icon {
        width: 32px;
        background: url(icons/directory_closed_cool-5.png);
    }
    .navbar-light .navbar-toggler .navbar-toggler-icon {
        width: 32px;
        background: url(icons/directory_open_cool-5.png);
    }
    .navbar-toggler{
        width: auto;
    }
    /*

    FOOTER

    */
    .taskbar{
        cursor: default;
        background-color: silver;
        margin: 16px 0 0 0;
        padding: 0 8px;
        position: static;
        bottom: 0;
        border-top: 2px outset #fff;
        z-index: 228;
        width: 100%;
        margin-right: 0px;
        margin-left: -15px;
        position: fixed;
        bottom: 0;
    }
    .taskbar .start-button {
        cursor: default;
        display: inline-block;
        border: 1px outset #fff;
        padding: 0 0 0 2px;
        box-shadow: 1px 1px #000;
        margin-bottom: 2px;
        font-size: 14px;
    }
    .taskbar .time {
        color:#212529;
        margin-top: 2px;
      
        text-align: right;
        font-size: 14px;
        margin-right: 0px;
    }
    #page-content {
        flex: 1 0 auto;
    }
    /*

    ICONS

    */
    .icon-16{
        margin-bottom:2px;
        max-height: 16px;
    }
    .icon-16-4{
        margin-bottom:4px;
        max-height: 16px;
    }
    /*

    FORMS

    */
    .form-95 {
        width: 100%;
        border: 2px inset #d5d5d5;
        color: #424242;
        background: #fff;
        box-shadow: -1px -1px 0 0 #828282;
        margin-top: 4px;
        padding-left:2px;
    }
    .bootstrap-select,
    textarea:focus, 
    textarea.form-control:focus, 
    input.form-control:focus, 
    input[type=text]:focus, 
    input[type=password]:focus, 
    input[type=email]:focus, 
    input[type=number]:focus, 
    [type=text].form-control:focus, 
    [type=password].form-control:focus, 
    [type=email].form-control:focus, 
    [type=tel].form-control:focus, 
    [contenteditable].form-control:focus {
        outline: 0 !important;
    }
    input[type="radio"],input[type="checkbox"] {
      position: absolute;
      left: -9999px;
    }

    .form-check-label::before, .form-check-label::after {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
    }
    .form-check-label{
        margin-left: 6px;
    }


    input[type="radio"] + .form-check-label::before,
    input[type="radio"] + .form-check-label::after {
      border-radius: 50%;
    }

    .form-check-label::before {
        height: 20px;
        width:20px;
        top: 3px;
        padding-right: 2px;
        border: 2px inset #d5d5d5;
        background: white;
        box-shadow: -1px -1px 0 0 #828282;
    }
    input[type="radio"] + .form-check-label::after {
      display: none;
      width: 8px;
      height: 8px;
      margin: 6px;
      top: 3px;
      background: black;
    }
    input[type="checkbox"] + .form-check-label::after {
        display: none;
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 8 8'%3e%3cpath fill='%23000' d='M6.564.75l-3.59 3.612-1.538-1.55L0 4.26 2.974 7.25 8 2.193z'/%3e%3c/svg%3e");
        width: 12px;
        height: 12px;
        margin: 4px;  
        top: 3px;
    }
    input:checked + .form-check-label::after {
      display: block;
    }
    /*

    Progress bar

    */
    .progress{
        height: 1rem;
        overflow: hidden;
        font-size: .75rem;
        background-color: silver;
        border-radius: 0rem;
        border: 1px inset #d5d5d5;
        color: #424242;
    }
    .progress-bar{
        display: -webkit-box;
        display: -ms-flexbox;
        display: flex;
        -webkit-box-orient: vertical;
        -webkit-box-direction: normal;
        -ms-flex-direction: column;
        flex-direction: column;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        justify-content: center;
        color: #fff;
        text-align: center;
        background-color: #1a0094;
        transition: width .6s ease;
    }
    .progress-bar-blocks{
        background-image: linear-gradient(90deg,transparent 75%,#d5d5d5 25%);
        background-size: 1rem 1rem;
    }

    /*

    TABS

    */
    .tab-content {
        background: silver;
        border: solid;
        border-width: 2px;
        border-bottom-color: #424242;
        border-right-color: #424242;
        border-left-color: #fff;
        border-top-color: silver;
        padding: 1rem 1.4rem;
    }
    .nav-tabs {
        border-bottom: 2px solid white;
    }
    .nav-tabs .nav-item {
        position: relative;
        margin-bottom: 0;
        background: #c0c0c0;
        color: black;
        border-top-left-radius: 4px;
        border-top-right-radius: 4px;
        border-right: 1px solid #5A5A5A;
        box-sizing: border-box;
    }
    .nav-tabs .nav-item .nav-link {
        color: black;
        padding: .2rem 1.8rem;
        box-sizing: border-box;
        transform: none;
    }
    .nav-tabs .nav-item .nav-link.active {
        position: relative;
        background: #c0c0c0;
    }
    .nav-tabs .nav-item:not(:first-child) .nav-link.active {
        border-left: 1px solid #5A5A5A;
    }
    .nav-tabs .nav-item:first-child{
        border-left: 2px solid white;
    }
    .nav-tabs .nav-item .nav-link.active:after {
        content: '';
        display: block;
        width: 100%;
        height: 2px;
        position: absolute;
        left: 0;
        bottom: -2px;
        background: #c0c0c0;
    }
    .nav-tabs .nav-link {
        border: 0;
        padding: 1rem 1rem;
    }

    /*

    MODAL
    TODO: make it draggable;

    */
    .modal-content{
        box-shadow: 1px 1px 0 0 #424242;
        border: 1px solid #fff;
        border-right-color: #848484;
        border-bottom-color: #848484;
        background: silver;
        padding: 2px;
    }
    .modal-header{
        height: 32px;
        background: -webkit-linear-gradient(left,#08216b,#a5cef7)!important;
        color:white;
        padding-top: 0px;
        padding-bottom: 0px;
        padding-left: 6px;
        padding-right: 6px;
    }
    .modal-header .btn{
        margin-top: 5px;
        padding-bottom: 10px;
        height: 22px;
        width: 22px;
    }
    .modal-header .btn span{
        position: absolute;
        top: 6px;
        right: 14px;
    }
    .modal-title{
        padding-top: 2px;
        padding-bottom: 1px;
    }
    .modal-footer{
        padding: 6px;
    }

    /*

    TABLES

    */
    .table{
        background: white;
        border-color: #c0c0c0;
    }
    .table-bordered{
        border: 1px solid #c0c0c0;
    }
    .table-bordered td, .table-bordered th {
        border: 1px solid #c0c0c0;
    }
    .table td, .table th {
        padding: .75rem;
        vertical-align: top;
        border-top: 1px solid #c0c0c0;
    }
    /* END WIN95 - BEGIN PALFUN */
    * {
      -webkit-font-smoothing: antialiased;
    }
    a {
      color: inherit;
      text-decoration: none;
    }
    a:hover {
      text-decoration: underline;
    }
    html {
      height: 100%;
      background-image: url('https://alexbsoft.github.io/win95.css/assets/clouds2.jpg');
      background-repeat: repeat;
    }
    body {
      padding: 0 1em;
    }
    ul, ol {
      margin: 0;
    }
    blockquote {
      margin: 0;
      padding: 0.5em 1em;
      border-left: 2px dotted black;
    }
    blockquote > .author {
      display: block;
      position: relative;
      top: -0.5em; left: -0.5em;
    }
    blockquote > .author::after {
      content: ' said:'
    }
    code {
      display: inline-block;
      vertical-align: middle;
      white-space: pre;
      font-family: Courier, monospace;
      padding: 0.5em;
      background-color: rgba(0,0,0,0.1);
    }

    #wrapper {
      display: flex;
      flex-direction: row;
      flex-wrap: wrap;
      margin: 1em auto;
      padding: 3px;
      max-width: 1500px;
    }

    #wrapper > h1 {
      margin: 0;
      margin-top: -2px;
      padding: 0.5em;
      width: 100%;
      font-size: 1.2em;
    }

    .header {
      display: flex;
      flex-direction: row;
      width: 100%;
      /*background-color: rgb(235,235,220);*/
      /*border-top: 2px solid rgba(255,255,255,0.5);*/
      /*border-bottom: 2px solid rgba(0,0,0,0.3);*/
      overflow-x: auto;
      overflow-y: hidden;
    }

    .header > div, .header > a {
      white-space: nowrap;
      text-decoration: none !important;
    }

    .header > a:hover {
      background-color: rgba(255,255,255,0.3);
    }

    .header > div {
      filter: grayscale(80%);
      opacity: .6;
    }

    .header summary, .header details {
      display: inline-block;
    }

    .header summary > .icon:hover {
      transform: rotate(80deg);
    }

    .header ::-webkit-details-marker, .header ::marker {
      display: none;
    }

    .header .icon {
      display: inline-block;
      margin-right: 0.2em;
      vertical-align: middle;
      transition: transform 0.5s cubic-bezier(0.64, -0.50, 0.67, 1.55);
    }

    .header > hr {
      display: inline;
      margin: 0 0.5em;
      border: none;
      height: 100%;
      width: 1px;
      background-color: rgba(0,0,0,0.3);
      vertical-align: middle;
    }

    .sidebar {
      flex-grow: 1;
      max-width: 25em;
      padding: 1.5em;
      overflow: scroll;
      /*background: linear-gradient(-40deg, #ffcba1 -5%, #02ccdf 60%, #02fcff);*/
      /*background-color: #02ccdf; */
      /*color: rgb(55,75,95);*/
      overflow: hidden;
    }

    .sidebar > h3 {
      box-sizing: border-box;
      margin: 0;
      padding: 0.5em 1em;
      width: 100%;
      /* background: linear-gradient(to right, rgb(250,255,255) 50%, rgb(205,210,250)); */
      /*background: linear-gradient(to right, #ffdbb1 50%, #02fcff);*/
      border-radius: 0.3em 0.3em 0 0;
      font-size: 1em;
      font-weight: bold;
    }

    .sidebar > div {
      margin-bottom: 1.5em;
    }

    .sidebar > div > a {
      display: block;
      margin-bottom: 0.1em;
    }

    .sidebar > div > form {
      margin: 0; padding: 0;
    }
    .sidebar > div > form > button {
      display: block;
      padding: 0;
      margin-bottom: 0.1em;
    }
    .sidebar > div > form > button:hover {
      cursor: pointer;
    }

    main {
      position: relative;
      flex-basis: 10em;
      flex-grow: 3;
      min-height: 100%;
      max-height: calc(100vh - 9.2em - 6px);
      overflow-x: hidden;
      overflow-y: auto;
      background-color: white;
      z-index: 0;
    }
    main > div {
      position: relative;
      padding-bottom: 8em;
      min-height: calc(100% - 10em);
    }

    main h1 {
      margin: 0.5em 1em;
      padding: 0;
      text-align: center;
      font-size: 2em;
      font-weight: bold;
    }

    main hr {
      border: none;
      height: 3px;
      width: 100%;
      margin-top: 0;
      margin-bottom: 1em;
      background: linear-gradient(to right, #08216b, white 70%);
    }

    main section a, main .tips a {
      text-decoration: underline;
      color: blue;
    }

    main > div > img {
      position: absolute;
      right: 0.2em; bottom: 0.2em;
      /* filter: grayscale(100%);
      opacity: .3; */
      z-index: -2;
    }
    main img.fg {
      filter: none;
      opacity: 1;
    }
    main .empty {
      color: grey;
      text-align: center;
      margin-top: 2em;
      margin-bottom: 6em;
    }
    main .tips {
      position: absolute;
      bottom: 1em; right: min(30%, 12em);
      padding: 1em;
      margin-left: 1em;
      max-width: 60%;
      background-color: rgb(245,245,105);
      border-radius: 3px;
      border: 1px solid black;
      z-index: -1;
    }

    article h1, article h2, article h3 {
      display: inline;
      margin: 0.5em 0 0 1em;
      font-size: 1em;
      font-weight: bold;
      text-decoration: none;
    }
    article h1 {
      display: block;
      margin-bottom: 0.2em;
    }

    article > section {
      margin: 0 1em 2em;
    }

    section img {
      max-width: 100%;
    }

    form {
      padding: 2em;
      padding-top: 0;
    }

    .pencil section {
      background-color: rgba(0,0,0,0.05);
      border: 2px dashed #00effe;
      padding: 1em;
    }

    form textarea {
      display: block;
      padding: 0.5em;
      width: 100%;
      height: 15em;
      margin-bottom: 1em;
      font-family: Courier, monospace;
    }

    form button {
      display: inline-block;
      margin: 0 1em 1em 0;
    }

    button {
      cursor: pointer;
    }

    '''
  ::
  ++  page
    ^-  manx
    ;html
      ;head
        ;title:"Invisible Networks 2023"
        ;style:"{(trip style)}"
        ;meta(charset "utf-8");
        ;meta
          =name     "viewport"
          =content  "width=device-width, initial-scale=1";
      ==
      ;body
        ;div#wrapper.card
          ;h1.card-header:"Invisible Networks 2023"
          ;+  render-toolbar
          ;+  render-sidebar
          ;+  render-content
        ==
      ==
    ==
  ::
  ++  fake-title
    |=  =^index
    ^-  tape
    =/  m=@  (mug index)
    ?+  (mod m 7)  !!
      %0  "📄 0x{((x-co:co 8) m)}.txt"
      %1  "📃 0x{((x-co:co 8) m)}.pdf"
      %3  "🖼 {((d-co:co 10) m)}.ppt"
      %4  "📊 {((d-co:co 10) m)}.xls"
      %2  "📑 {((d-co:co 10) m)}.doc"
      %5  "💾 {(scow %uw m)}.jam"
      %6  "🎵 0x{((x-co:co 8) m)}.mp3.exe"
    ==
  ::
  ++  prompt-title
    |=  sprout=(unit @ud)
    =?  sprout  &(?=(~ sprout) ?=(^ index))
      `sprout:(~(got by library) u.index)
    =;  =tape
      "{tape}.{(trip (snag (need sprout) ^sprouts))}"
    =+  s=(need sprout)
    ?:  (gth s 13)  ((x-co:co 2) (sub s 4))
    (y-co:co +(s))
  ::
  ++  date-format
    ::NOTE  this reimplements +dust:chrono:userlib to be better
    =,  chrono:userlib
    |=  d=@da
    ^-  tape
    =/  yed  (yore d)
    =/  wey  (daws yed)
    =/  num  (d-co:co 1)
    =/  dub  y-co:co
    =/  pik  |=([n=@u t=wall] `tape`(scag 3 (snag n t)))
    ::
    "{(pik wey wik:yu)}, ".
    "{(num d.t.yed)} {(pik (dec m.yed) mon:yu)} {(num y.yed)} ".
    "{(dub h.t.yed)}:{(dub m.t.yed)}:{(dub s.t.yed)}"
  ::
  ::
  ++  link-to-pencil
    |=  where=$@(sprout=@ud ^index)
    ?@  where  (weld (link-to-sprout sprout.where) "&e")
    (weld (link-to-single where) "&e")
  ::
  ++  link-to-single
    |=  ^index
    "/invisible-networks?a={(scow %p author)}&i={(a-co:co id)}"
  ::
  ++  link-to-sprout
    |=  sprout=@ud
    "/invisible-networks?p={(a-co:co +(sprout))}"
  ::
  ++  link-to-author
    |=  author=@p
    "/invisible-networks?a={(scow %p author)}"
  ::
  ++  find-prev-and-next
    |=  [for=^index lis=(list ^index)]  ~+
    ^-  [prev=(unit ^index) next=(unit ^index)]
    ::NOTE  this does way more list traversals than necessary,
    ::      but the lists aren't likely to get very big,
    ::      and this is more legible implementation.
    =/  hit=(unit @)
      (find [for]~ lis)
    ?~  hit  ~&([dap %strange-miss index] [~ ~])
    :_  (snug +(u.hit) lis)
    ?:  =(0 u.hit)  ~
    ^-  (unit ^index)
    (snug (dec u.hit) lis)
  ::
  ::
  ++  render-toolbar  ^-  manx
    =/  [prev=(unit tape) next=(unit tape)]
      ?+  format  [~ ~]
          %sprout
        =/  sprout=@ud  (need sprout)
        :-  ?:(=(0 sprout) ~ `(link-to-sprout (dec sprout)))
        ?:((gte +(sprout) (lent sprouts)) ~ `(link-to-sprout +(sprout)))
      ::
          %single
        =/  =^index  (need index)
        ?.  (~(has by library) index)  [~ ~]
        =-  [(bind prev link-to-single) (bind next link-to-single)]
        %+  find-prev-and-next  index
        (flop (~(get ja volumes) sprout:(~(got by library) index)))
      ==
    =/  up=tape
      ?+  format  "/invisible-networks"
          %single
        ?~  story=(~(get by library) (need index))
          "/invisible-networks"
        (link-to-sprout sprout.u.story)
      ::
          %pencil
        ?~  index  (link-to-sprout (need sprout))
        (link-to-single u.index)
      ==
    ::
    ;nav.header.navbar.navbar-light.navbar-95
      ;+  :-  ?~  prev  [%div [%class "nav-link"] ~]
              [%a [%href u.prev] [%class "nav-link"] ~]
          :~  ;span.icon:"⬅️"
              :/"previous"
          ==
      ;+  :-  ?~  next  [%div [%class "nav-link"] ~]
              [%a [%href u.next] [%class "nav-link"] ~]
          :~  ;span.icon:"➡️"
              :/"next"
          ==
      ;+  :-  ?~  args  [%div [%class "nav-link"] ~]
              [%a [%href "{up}"] [%class "nav-link"] ~]
          :~  ;span.icon:"⬆️"
          ==
      ;hr;
      ;div.nav-link
        ;span.icon:"🔎"
        ; search
      ==
      ;div.nav-link
        ;span.icon:"📁"
        ; folders
      ==
      ;hr;
      ;div.nav-link
        ;details
          ;summary  ;span.icon:"🏄‍♀️"  ==
          ; by tocrex-holpen & paldev
        ==
      ==
    ==
  ::
  ++  render-sidebar  ^-  manx
    |^  ;nav.sidebar
          ;*  ?~  msg  ~
              :~  ;h3:"{?:(-.u.msg "Message" "Warning")}"
                  ;div  ;+  :/"‼️ {(trip +.u.msg)}"  ==
              ==
        ::
          ;div.card
            ;div.card-header  ;h3:"System Tasks"  ==
            ;div.card-body  ;*  tasks  ==
          ==
        ::
          ;div.card
            ;div.card-header  ;h3:"Other Places"  ==
            ;div.card-body  ;*  spots  ==
          ==
        ::
          ;div.card
            ;div.card-header  ;h3:"Details"  ==
            ;div.card-body  ;*  deets  ==
          ==
        ==
    ::
    ++  tasks  ^-  marl
      ::  always show at least one "task"
      ::
      =-  ?.  =(~ -)  -
          ;+  ;a/"#":"⏳ Witness the Passage of Time"
      ::  show a button for "like"ing the story if it's not ours
      ::
      =;  tax
        ?.  ?=(%single format)  tax
        =/  =^index  (need index)
        ?:  =(our author.index)  tax
        =/  likes  likes:(~(gut by library) index *story)
        %+  snoc  tax
        =/  count=tape
          =/  c  ~(wyt in likes)
          ?:(=(0 c) "" " ({(a-co:co c)})")
        ?:  (~(has in likes) our)
          :/"💖 Thanked the Author for their Work{count}"
        ;form(method "post")
          ;input(type "hidden", name "i", value "{(a-co:co id.index)}");
          ;input(type "hidden", name "a", value "{(scow %p author.index)}");
          ;button(type "submit", name "like")
            ; 💗 Thank the Author for their Work
            ;+  :/"{count}"
          ==
        ==
      ::  declare sidebar links conveniently
      ::
      =-  ^-  marl
          %+  murn  -
          |=  u=(unit [tape tape])
          (bind u |=([u=tape t=tape] ;a/"{u}":"{t}"))
      :~  =?  sprout  &(?=(~ sprout) ?=(^ index))
            ?~  story=(~(get by library) u.index)  ~
            `sprout.u.story
          ?~  sprout  ~
          %+  some
            (link-to-pencil u.sprout)
          "📄 New Document about this Topic"
        ::
          ?:  ?=(%pencil format)
            %+  some
              ?:  ?&  ?=(^ index)
                      (~(has by library) u.index)
                  ==
                (link-to-single u.index)
              (link-to-sprout (need sprout))
            "❌ Discard Changes"
          ?.  ?&  ?=(^ index)
                  =(our author.u.index)
                  (~(has by library) u.index)
              ==
            ~
          %+  some
            (link-to-pencil u.index)
          "📝 Edit this Document"
      ==
    ::
    ++  spots  ^-  marl
      =-  %+  murn  -
          |=  u=(unit [tape tape])
          (bind u |=([u=tape t=tape] ;a/"{u}":"{t}"))
      =/  story  (biff index ~(get by library))
      :~  ?.  ?=(%single format)  ~
          ?~  story  ~
          %+  some
            (link-to-author author:(need story))
          "👤 More by this Author"
        ::
          ?.  ?=(%single format)  ~
          ?~  story  ~
          %+  some
            (link-to-sprout sprout:(need story))
          "📚 More about this Topic"
        ::
          (some "/invisible-networks" "📅 Topic of the Day")
          (some (link-to-author our) "📁 Your Documents")
      ==
    ::
    ++  deets  ^-  marl
      |-
      ?-  format
          %pencil
        ?:  &(?=(^ index) (~(has by library) u.index))
          $(format %single)
        :~  ;b:"New Document"
            ;br;
            :/"{(prompt-title sprout)}"
        ==
      ::
          %single
        ?:  !(~(has by library) (need index))  [:/"???"]~
        =/  =story  (~(got by library) (need index))
        :*  ;b:"{(fake-title (need index))}"
            ?:(echoed.story :/"" ;span(title "Saving..."):" (⏳)")
            ;br;
            :/"{(prompt-title sprout)}"
            ;br;
            ;br;
          ::
            =/  [n=@ud w=tape]
              =/  d=@dr  (sub (max date.story now) date.story)
              =/  n=@ud  (div d ~d1)
              ?.  =(0 n)  [n "day"]
              =.  n      (div d ~h1)
              ?.  =(0 n)  [n "hour"]
              [(div d ~m1) "minute"]
            ;span(title "{(a-co:co n)} {w}(s) ago.")
              ;+  :/"Date Modified: {(date-format date.story)}"
            ==
          ::
            ;br;
            ?.  &(=(our author.story) !=(~ likes.story))
              :_  ~
              :/"By: {+:(scow %p author.story)}"
            :~  :/"By: You!"
                ;br;
                ;br;
              ::
                =;  t
                  ;span(title t)
                    ;+  :/"Thanked {(a-co:co ~(wyt in likes.story))} time(s)."
                  ==
                %+  roll  ~(tap in likes.story)
                |=  [=@p t=tape]
                ?~  t  "by {(scow %p p)}"
                "{t}, {(scow %p p)}"
            ==
        ==
      ::
          %sprout
        :~  ;b:"{(prompt-title sprout)}"
            ;br;
            ?^  args  :/"Category"
            :/"Category of the day"
            ;br;
            ;br;
            =/  time  (add start (mul ~d1 (need sprout)))
            =/  when  (flop (slag 9 (flop (date-format time))))
            :/"Date Modified: {when}"
        ==
      ::
          %author
        :~  ;b:"{+:(scow %p (need author))}"
            ;br;
            :/"Author"
        ==
      ::
          %biding
        :~  ;b:"Silence"
            ;br;
            :/"Date Modified: {(date-format start)}"
        ==
      ==
    ::
    ++  rend
      |=  all=(list (unit [tape tape]))
      %+  murn  all
      |=  u=(unit [tape tape])
      (bind u |=([u=tape t=tape] ;a/"{u}":"{t}"))
    --
  ::
  ::
  ++  render-content  ^-  manx
    |^  ;main(class "{(trip format)}")  ;div
          ;*  ?-  format
                %pencil  render-pencil
                %single  render-single
                %sprout  render-sprout
                %author  render-author
                %biding  render-biding
        ==  ==  ==
    ::
    ++  render-pencil  ^-  marl
      =/  content  (~(get by args) 'content')
      =/  id=@
        %+  fall  id
        =/  nex  (mod eny 900)
        |-
        =/  rid  (add 100 nex)
        ?.  (~(has by library) [our rid])  rid
        $(nex (mod +(nex) 900))
      ^-  marl
      :~
        %+  article  [our id]
        =;  =story
          story(body (fall content ''))
        ?~  sprout  (~(got by library) [our id])
        (~(gut by library) [our id] [our & ~ u.sprout now ''])
      ::
        ^-  manx
        ;form(method "post", id "pencil")
          ;textarea(name "content")
            ;+  =-  :/"{(trip -)}"
            %+  fall  (~(get by args) 'content')
            ?~  index  ''
            body:(~(got by library) u.index)
          ==
          ;*  ?~  sprout  ~
              ;+  ;input(type "hidden", name "p", value "{(a-co:co u.sprout)}");
          ;input(type "hidden", name "i", value "{(a-co:co id)}");
          ;button.btn.btn-primary(type "submit", name "save"):"💾 Save"
          ;button.btn.btn-primary(type "submit", name "show"):"👁 Preview"
          ;button.btn.btn-primary
            =type  "submit"
            =name  "nuke"
            =onclick  "return confirm('Are you sure you want to delete this file?');"
            ; 🗑 Delete...
          ==
        ==
      ::
        ;div.tips
          ;+  :/"You can use BBCode! For example, [b]"
          ;b:"bold"
          ;+  :/"[/b] or [color=red]"
          ;span(style "color: red"):"color"
          ; [/color] or
          ;a/"/invisible-networks/bbcode.txt"(target "_blank"):"others"
          ; .
        ==
        ;img@"https://pal.dev/props/inet2022/clippy-gun.gif";
      ==
    ::
    ++  render-single  ^-  marl
      =/  =^index  (need index)
      ?~  story=(~(get by library) index)
        ;*  :~
          ;div.tips:"You dun goofed."
          ;img@"https://pal.dev/props/inet2022/clippy-gun.gif";
        ==
      ;+  (article index u.story)
    ::
    ++  render-sprout  ^-  marl
      =/  sprout=@ud  (need sprout)
      :-  ;h1:"{(prompt-title `sprout)}"
      =/  stories  (~(get ja volumes) sprout)
      ?:  =(~ stories)
        ;*  :~
          ;div.empty:"This folder is empty."
          ;div.tips
            ;+  :/"You can help by "
            ;a/"{(link-to-pencil sprout)}":"expanding this section"
            ; .
          ==
          ;img.fg@"https://pal.dev/props/inet2022/clippy-gun.gif";
        ==
      %+  turn  stories
      |=  =^index
      (article index (~(got by library) index))
    ::
    ++  render-author  ^-  marl
      =/  author=@p  (need author)
      :-  ;h1:"{+:(cite:title author)}'s Documents"
      =/  stories  (~(get ja authors) author)
      ?:  =(~ stories)
        ;+  ;div.empty:"This folder is empty."
      %+  turn  stories
      |=  =^index
      (article index (~(got by library) index))
    ::
    ++  render-biding  ^-  marl
      =/  rem=@ud
        ?:  (gth now start)  0
        (div (sub start now) ~h1)
      ;=  ;div.empty:"{(a-co:co rem)} hour(s) remain."
          ;div.tips:"Your time will come. Soon..."
          ;img.fg@"https://pal.dev/props/inet2022/clippy-gun.gif";
      ==
    ::
    ::
    ++  article
      |=  [=^index =story]  ^-  manx
      ;article
        ;*  ?.  ?=(?(%author %single %pencil) format)  ~
            ;+  ;a/"{(link-to-sprout sprout.story)}"
                  ;h1:"{(prompt-title `sprout.story)}"
                ==
        ;a/"{(link-to-single index)}"
          ;h2:"{(fake-title index)}"
        ==
        ;+  ?:(echoed.story :/"" ;span(title "Saving..."):" (⏳)")
        ;*  ?:  ?=(%author format)  ~
            ;+  ;h3
                  ;+  :/" by "
                  ;a/"{(link-to-author author.story)}"
                    ;  {+:(scow %p author.story)}
            ==    ==
        ;hr;
        ;*  ?:  =('' body.story)  ~
            ;+  ;section
              ;*  (render:bbcode (obtain:bbcode body.story))
            ==
      ==
    --
  --
--
