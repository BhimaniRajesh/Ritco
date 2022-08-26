var freq=5

var random_num=Math.floor(Math.random()*freq)
if (random_num==0)
window.onload=initbox
var ie=document.all
var dom=document.getElementById
var ns4=document.layers
var calunits=document.layers? "" : "px"

var bouncelimit=32 //(must be divisible by 8)
var direction="up"

function initbox(){
if (!dom&&!ie&&!ns4)
return
crossobj=(dom)?document.getElementById("dropin").style : ie? document.all.dropin : document.dropin
scroll_top=(ie)? truebody().scrollTop : window.pageYOffset
crossobj.top=scroll_top-250//+calunits
crossobj.width=300
crossobj.height=250
crossobj.visibility=(dom||ie)? "visible" : "show"
dropstart=setInterval("dropin()",50)
}
var win = null;
function NewWindow(mypage,myname,w,h,scroll){
LeftPosition = (screen.width) ? (screen.width-w)/2 : 0;
TopPosition = (screen.height) ? (screen.height-h)/2 : 0;
settings =
'height='+h+',width='+w+',top='+TopPosition+',left='+LeftPosition+',scrollbars='+scroll+',resizable'
win = window.open(mypage,myname,settings)
}

function dropin(){
scroll_top=(ie)? truebody().scrollTop : window.pageYOffset
if (parseInt(crossobj.top)<200+scroll_top)
crossobj.top=parseInt(crossobj.top)+50+calunits
else{
clearInterval(dropstart)
bouncestart=setInterval("bouncein()",50)
}
}

function bouncein(){
crossobj.top=parseInt(crossobj.top)-bouncelimit+calunits
if (bouncelimit<0)
bouncelimit+=8
bouncelimit=bouncelimit*-1
if (bouncelimit==0){
clearInterval(bouncestart)
}
}

function dismissbox(){
if (window.bouncestart) clearInterval(bouncestart)
crossobj.visibility="hidden"
}

function truebody(){
return (document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body
}