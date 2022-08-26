<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="AutoEmail_Step2.aspx.cs" Inherits="GUI_admin_AutoEmail_AutoEmail_Step2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <link rel="stylesheet" href="./css/mootime.css" type="text/css" media="screen" />

    <script language="javascript" type="text/jscript">
    function OpenPopupMF(MF)
    {
//        var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
//        var strPopupURL = "../../../Operations/TCS/PrintTCS/FrmMenifestView.aspx?MFNo=" + MF +",0"
//        winNew = window.open(strPopupURL, "_blank", strWinFeature)
          window.open("../../../Operations/TCS/PrintTCS/FrmMenifestView.aspx?MFNo=" + MF +",0","es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
    }
    
    </script>

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>

    <script type="text/javascript" language="JavaScript" src="./js/jquery.js"></script>

    <script type="text/javascript" language="JavaScript" src="./js/dimensions.js"></script>

    <script type="text/javascript" language="JavaScript" src="./js/jquery.ptTimeSelect.js"></script>

    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

    <%--<script src="./js/mootools1.2.js" language="javascript" type="text/javascript"></script> --%>
    <%--<script src="./js/mootime.js" language="javascript" type="text/javascript"></script>  --%>

    <script type="text/javascript" language="JavaScript">

		$(document).ready(
			function () {
				$('code').each(
					function() {
						eval($(this).html());
					}
				)
			}
		);

/*	-------------[ COMMENT OUT FOR NOW.]

		$(document).ready(
			
			function () {
				
				$.get(
					'../doc/files/jquery-ptTimeSelect-js.html',
					'',
					function (help) {
						//help = $("body", help);
						$('div.CFunction[:contains("ptTimeSelect()")]', $(help)).appendTo('#usageDoc');
						
					}
				);	
			}
			
		);
----------------------------------------------- */
		
    </script>

    <script language="javascript" type="text/javascript">
//    window.addEvent('domready', function() {            
//mootime('document.getElementById("ctl00_MyCPH1_goin_left")');
////mootime('goin_right');
////mootime('goin_down_left');
////mootime('goin_down_right'); 
//});
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();

     
    function OnChdllOccEVE() 
       {
       // alert("Hi")
       regenerate2
       GetToolTip() 
       }
    
    function GetToolTip() 
       {
            var DllOccurs=document.getElementById("ctl00_MyCPH1_DllOccurs");
            var dllOccEVE=document.getElementById("ctl00_MyCPH1_dllOccEVE");
             var dllHR=document.getElementById("ctl00_MyCPH1_dllHR");
              var txtSttime=document.getElementById("ctl00_MyCPH1_txtSttime");
               var txtEntime=document.getElementById("ctl00_MyCPH1_txtEntime");
          var txtDateFrom=document.getElementById("ctl00_MyCPH1_txtDateFrom");
               var txtDateTo=document.getElementById("ctl00_MyCPH1_txtDateTo");
                 var DllOnMnweek=document.getElementById("ctl00_MyCPH1_DllOnMnweek");
               var DllOnMnDays=document.getElementById("ctl00_MyCPH1_DllOnMnDays");
             //  var DOCTYP=DllOccurs;
      //   alert(DllOccurs)
         if(DllOccurs.value=="4")
         {
           changetext("Occurs Daily every "+dllOccEVE.value+" "+dllHR.value+" between "+txtSttime.value+" and "+txtEntime.value+". Schedule will be used between "+txtDateFrom.value+" and "+txtDateTo.value+". ")   
         }
          else if(DllOccurs.value=="8")
         {
            var str_week="";
            var chakval=""
            for(im=0;im<7;im++)
		    {
		    
		              
			        
			    if(document.getElementById("ctl00_MyCPH1_chkWeek_"+im).checked == true)
			    {	
			        if(im=="0")
			            chakval="Monday"
			             if(im=="1")
			            chakval="Tuesday"
			             if(im=="2")
			            chakval="Wednesday"
			             if(im=="3")
			            chakval="Thursday"
			             if(im=="4")
			              chakval="Friday"
			              if(im=="5")
			            chakval="Saturday"
			             if(im=="6")
			            chakval="Saturday"            
			           
			            
			        
			      if(str_week=="")
			         str_week=chakval
			      else 
			         str_week=str_week+","+chakval
			    }
		    }
         
          changetext("Occurs every Week on "+str_week+" every "+dllOccEVE.value+" "+dllHR.value+" between "+txtSttime.value+" and "+txtEntime.value+". Schedule will be used between "+txtDateFrom.value+" and "+txtDateTo.value+". ")   
       
         }
          else if(DllOccurs.value=="16")
         {
          changetext("Occurs every "+DllOnMnweek.value+"  "+DllOnMnDays.value+"  every Month  "+dllOccEVE.value+" "+dllHR.value+" between "+txtSttime.value+" and "+txtEntime.value+". Schedule will be used between "+txtDateFrom.value+" and "+txtDateTo.value+". ")   
       
         }
       }
    
 function SelectDOC() 
       {
         var DOCTYP=document.getElementById("ctl00_MyCPH1_DllOccurs");
            GetToolTip() 
         if(DOCTYP.value=="4")
         {
                 document.getElementById('ctl00_MyCPH1_TrDaily').style.display = "block";    
                  document.getElementById('ctl00_MyCPH1_TrWeekly').style.display = "none";    
                   document.getElementById('ctl00_MyCPH1_TrMonthly').style.display = "none"; 
                   
                  // changetext("Daily ")   
         }
         else if(DOCTYP.value=="8")
         {
          document.getElementById('ctl00_MyCPH1_TrDaily').style.display = "block";    
                  document.getElementById('ctl00_MyCPH1_TrWeekly').style.display = "block";    
                   document.getElementById('ctl00_MyCPH1_TrMonthly').style.display = "none";  
                  // changetext("Weekly")   
         }
          else if(DOCTYP.value=="16")
         {
          document.getElementById('ctl00_MyCPH1_TrDaily').style.display = "block";    
                  document.getElementById('ctl00_MyCPH1_TrWeekly').style.display = "none";    
                   document.getElementById('ctl00_MyCPH1_TrMonthly').style.display = "block";
                    //changetext("Monthaly")       
         }
       
       }
       
       
       function OnSubmit1()
       {
             DllListRPT=document.getElementById("ctl00_MyCPH1_DllListRPT");
             if(DllListRPT.value=="")
             {
                alert("Plz Select One Report ")
                DllListRPT.focus();
                return false;
             }
             
            document.getElementById('ctl00_MyCPH1_tr1').style.display = "block";    
            document.getElementById('ctl00_MyCPH1_tr2').style.display = "block";    
       }
       
       function OnSubmit2()
       {
              hd1=  document.getElementById("ctl00_MyCPH1_hd1");
             ij=hd1.value
               var i=-1;
              //  alert(ij)       
               for(dkt=0;dkt<ij;dkt++)
                {           
                    if(document.getElementById('ctl00_MyCPH1_chkDesig_'+dkt).checked == true)    
                    {
                      //  alert(dkt)
                        i=dkt;
                    }          
                }
                
                if(i==-1)
                {
                    alert("Plz Check atleast one Designation !! ")                 
                    return false;
                }
       
            dllProfile=document.getElementById("ctl00_MyCPH1_dllProfile");
             if(dllProfile.value=="")
             {
                alert("Plz Select One Sender Profile ")
                dllProfile.focus();
                return false;
             }
        GetToolTip() 
       }
        function OnSubmit3()
       {
       
             DllOccurs=document.getElementById("ctl00_MyCPH1_DllOccurs");
             if(DllOccurs.value=="")
             {
                alert("Plz Select One  ")
                DllOccurs.focus();
                return false;
             }
             
             if(DllOccurs.value=="8")
             {
             var i=-1;
              //  alert(ij)       
               for(dkt=0;dkt<7;dkt++)
                {           
                    if(document.getElementById('ctl00_MyCPH1_chkWeek_'+dkt).checked == true)    
                    {
                      //  alert(dkt)
                        i=dkt;
                    }          
                }
                
                if(i==-1)
                {
                    alert("Plz Check atleast one Week Day !! ")                 
                    return false;
                }
                }
              
       }
       ///////////////////Tool Tip
       
       function regenerate(){
window.location.reload()
}
function regenerate2(){
if (document.layers){
appear()
setTimeout("window.onresize=regenerate",450)
}
}

function changetext(whichcontent){

if (document.all||document.getElementById){
cross_el=document.getElementById? document.getElementById("descriptions"):document.all.descriptions
cross_el.innerHTML='<font face="Verdana"><small>'+whichcontent+'<font></small>'
}
else if (document.layers){
document.d1.document.d2.document.write('<font face="Verdana" color="blue"><small>'+whichcontent+'</small></font>')
document.d1.document.d2.document.close()
}

}

function appear(){
document.d1.visibility='show'
}

window.onload=OnChdllOccEVE



    </script>

    <table cellspacing="1" style="width: 8.0in">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Auto E-mail  Select Report Step -2</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../images/loading.gif" alt="" />
                    </td>
                    <td>
                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                opacity: .50; -moz-opacity: .50;" runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                    left: 50%;" ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>
    &nbsp;&nbsp;&nbsp;
    <asp:UpdatePanel ID="ut1" runat="server">
        <ContentTemplate>
            <table cellspacing="1" style="width: 8.0in">
                <tr>
                    <td align="left" width="15%">
                        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 7.0in">
                            <tr class="bgbluegrey">
                                <td style="text-align: center" class="blackfnt">
                                    Set Report
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td style="text-align: left" class="blackfnt">
                                    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 7.0in">
                                        <tr style="background-color: White">
                                            <td style="text-align: left" class="blackfnt">
                                                &nbsp;Select Report
                                            </td>
                                            <td style="text-align: left" class="blackfnt">
                                                <asp:DropDownList ID="DllListRPT" runat="server" CssClass="blackfnt" OnChange="Javascript:return SelectDOC();">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr style="background-color: White">
                                            <td style="text-align: right" colspan="2" class="blackfnt">
                                                &nbsp;&nbsp;&nbsp;<asp:Button ID="BtnStep1" runat="server" Text="Step -1 " OnClientClick="Javascript:return OnSubmit1();"
                                                    CssClass="blackfnt" OnClick="BtnStep1_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="tr1" runat="server" class="bgbluegrey" style="display: none">
                                <td style="text-align: center" class="blackfnt">
                                    Set Designation
                                </td>
                            </tr>
                            <tr id="tr2" runat="server" style="background-color: White; display: none">
                                <td style="text-align: left" class="blackfnt">
                                    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 7.0in">
                                        <tr style="background-color: White">
                                            <td style="text-align: left" class="blackfnt">
                                                &nbsp;Select Designation
                                            </td>
                                            <td style="text-align: left" class="blackfnt">
                                              <asp:CheckBoxList ID="chkDesig" runat="server" CssClass="blackfnt" RepeatColumns="3"
                                                    RepeatDirection="horizontal">
                                                </asp:CheckBoxList>
                                                <asp:HiddenField  ID="hd1" runat="server"/>
                                                 
                                            </td>
                                        </tr>
                                        <tr style="background-color: White">
                                            <td style="text-align: left" class="blackfnt">
                                                &nbsp;Select Sender Profile
                                            </td>
                                            <td style="text-align: left" class="blackfnt">
                                              <asp:DropDownList ID="dllProfile" runat="server" CssClass="blackfnt" OnChange="Javascript:return SelectDOC();">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr style="background-color: White">
                                            <td style="text-align: right" colspan="2" class="blackfnt">
                                                &nbsp;&nbsp;&nbsp;<asp:Button ID="BtnStep2" runat="server" Text="Step -2 " OnClientClick="Javascript:return OnSubmit2();"
                                                    CssClass="blackfnt" OnClick="BtnStep2_Click" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr class="bgbluegrey" id="tr3" runat="server" style="display: none">
                                <td style="text-align: center" class="blackfnt">
                                    Set Report Frequency
                                </td>
                            </tr>
                            <tr id="tr4" runat="server" style="background-color: White; display: none">
                                <td style="text-align: left" class="blackfnt">
                                    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 7.0in">
                                        <tr style="background-color: White">
                                            <td style="text-align: left" class="blackfnt">
                                                &nbsp;Occurs
                                            </td>
                                            <td style="text-align: left" class="blackfnt">
                                                <asp:DropDownList ID="DllOccurs" runat="server" CssClass="blackfnt" OnChange="Javascript:return SelectDOC();">
                                                    <asp:ListItem Value="4" Text="Daily"></asp:ListItem>
                                                    <asp:ListItem Value="8" Text="Weekly"></asp:ListItem>
                                                    <asp:ListItem Value="16" Text="Monthly"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr id="TrDaily" runat="server" style="background-color: White">
                                            <td colspan="2">
                                                <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 7.0in">
                                                    <tr style="background-color: White">
                                                        <td style="text-align: left" class="blackfnt">
                                                            Occur Evwry:&nbsp;<asp:DropDownList ID="dllOccEVE" Height="20" runat="server" OnChange="Javascript:return OnChdllOccEVE();">
                                                                <%--<asp:DropDownList ID="dllOccEVE" Height="20" runat="server" CssClass="blackfnt" >--%>
                                                           
                                                                <asp:ListItem Text="06" Selected="True" Value="06"></asp:ListItem>
                                                                
                                                                <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                                                   <asp:ListItem Text="18" Value="18"></asp:ListItem>
                                                                      <asp:ListItem Text="24" Value="24"></asp:ListItem>
                                                                <%--</asp:DropDownList>--%>
                                                            </asp:DropDownList>
                                                            <asp:DropDownList ID="dllHR" Height="20" runat="server" CssClass="blackfnt" OnChange="Javascript:return OnChdllOccEVE();">
                                                                <asp:ListItem Text="hour(s)" Selected="True"></asp:ListItem>
                                                                <%--<asp:ListItem Text="minute(s)"></asp:ListItem>--%>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="text-align: left;" class="blackfnt">
                                                            Starting AT :&nbsp;
                                                            <div id="ptTimeSelect_1" style="display: inline;">
                                                                <asp:TextBox ID="txtSttime" Width="53" OnChange="Javascript:return OnChdllOccEVE();"
                                                                    onblur="Javascript:return OnChdllOccEVE();" onclick="jQuery.ptTimeSelect.openCntr('ptTimeSelect_1');"
                                                                    runat="server" Text="12:00 PM" CssClass="blackfnt"></asp:TextBox>
                                                                <%--<a onclick="jQuery.ptTimeSelect.openCntr('ptTimeSelect_1');" href="javascript:void(0);">[T]</a></div>--%>
                                                        </td>
                                                    </tr>
                                                    <tr style="background-color: White">
                                                        <td style="text-align: left" class="blackfnt">
                                                        </td>
                                                        <td style="text-align: left" class="blackfnt">
                                                            Ending AT :&nbsp;
                                                            <div id="ptTimeSelect_2" style="display: inline;">
                                                                <asp:TextBox ID="txtEntime" Width="53" onblur="Javascript:return OnChdllOccEVE();"
                                                                    onclick="jQuery.ptTimeSelect.openCntr('ptTimeSelect_2');" runat="server" Text="11:45 PM"
                                                                    CssClass="blackfnt"></asp:TextBox>
                                                                <%--<a onclick="jQuery.ptTimeSelect.openCntr('ptTimeSelect_2');" href="javascript:void(0);">[T]</a></div> --%>
                                                        </td>
                                                    </tr>
                                                    <tr style="background-color: White">
                                                        <td style="text-align: left" class="blackfnt">
                                                            Start Date :&nbsp;
                                                            <asp:TextBox onblur="Javascript:return OnChdllOccEVE();" ID="txtDateFrom" runat="Server"
                                                                ValidationGroup="VGDtFromTo" Width="60" MaxLength="10"></asp:TextBox>
                                                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy');return false;return OnChdllOccEVE();"
                                                                name="anchor1" id="anchor1">
                                                                <img src="./../../images/calendar.jpg" border="0"></img>
                                                            </a>
                                                        </td>
                                                        <td style="text-align: left" class="blackfnt">
                                                            End Date:&nbsp;<asp:TextBox onblur="Javascript:return OnChdllOccEVE();" ID="txtDateTo"
                                                                runat="Server" ValidationGroup="VGDtFromTo" Width="60" MaxLength="10"></asp:TextBox>
                                                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy');return false;return OnChdllOccEVE();"
                                                                name="anchor2" id="a1">
                                                                <img src="./../../images/calendar.jpg" border="0"></img>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr id="TrWeekly" runat="server" style="background-color: White; display: none;">
                                            <td colspan="2">
                                                <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 7.0in">
                                                    <tr style="background-color: White">
                                                        <td style="text-align: left" class="blackfnt">
                                                            Week Days:&nbsp;
                                                            <asp:CheckBoxList ID="chkWeek" RepeatDirection="horizontal" runat="server" CssClass="blackfnt"
                                                                onclick="Javascript:return OnChdllOccEVE();">
                                                                <asp:ListItem Text="Monday " Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="Tuesday" Value="2"></asp:ListItem>
                                                                <asp:ListItem Text="Wednesday" Value="4"></asp:ListItem>
                                                                <asp:ListItem Text="Thursday" Value="8"></asp:ListItem>
                                                                <asp:ListItem Text="Friday" Value="16"></asp:ListItem>
                                                                <asp:ListItem Text="Saturday" Value="32"></asp:ListItem>
                                                                <asp:ListItem Text="Sunday" Value="64"></asp:ListItem>
                                                            </asp:CheckBoxList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr id="TrMonthly" runat="server" style="background-color: White; display: none;">
                                            <td colspan="2">
                                                <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 7.0in">
                                                    <tr style="background-color: White">
                                                        <td style="text-align: left" class="blackfnt">
                                                            On :&nbsp;
                                                            <asp:DropDownList ID="DllOnMnweek" Height="20" runat="server" OnChange="Javascript:return OnChdllOccEVE();">
                                                                <asp:ListItem Text="First" Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="Second" Value="2"></asp:ListItem>
                                                                <asp:ListItem Text="Third" Value="4"></asp:ListItem>
                                                                <asp:ListItem Text="Forth" Value="8"></asp:ListItem>
                                                                <asp:ListItem Text="Last" Value="16"></asp:ListItem>
                                                            </asp:DropDownList>
                                                            <asp:DropDownList ID="DllOnMnDays" Height="20" runat="server" OnChange="Javascript:return OnChdllOccEVE();">
                                                                <asp:ListItem Text="Monday " Value="1"></asp:ListItem>
                                                                <asp:ListItem Text="Tuesday" Value="2"></asp:ListItem>
                                                                <asp:ListItem Text="Wednesday" Value="3"></asp:ListItem>
                                                                <asp:ListItem Text="Thursday" Value="4"></asp:ListItem>
                                                                <asp:ListItem Text="Friday" Value="5"></asp:ListItem>
                                                                <asp:ListItem Text="Saturday" Value="6"></asp:ListItem>
                                                                <asp:ListItem Text="Sunday" Value="7"></asp:ListItem>
                                                                <asp:ListItem Text="Day" Value="8"></asp:ListItem>
                                                                <asp:ListItem Text="Week Day" Value="9"></asp:ListItem>
                                                                <asp:ListItem Text="Week End Day" Value="10"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr id="Tr5" runat="server" style="background-color: White; display: none;">
                                            <td colspan="2" align="center">
                                           <asp:Button ID="btnSubmit3" runat="server" Text="Submit" OnClientClick="Javascript:return OnSubmit3();"
                                                    CssClass="blackfnt" OnClick="BtnStep3_Click" />
                                            </td>
                                        </tr>
                                        <tr style="background-color: White">
                                            <td colspan="2">
                                                <ilayer id="d1" width="200" height="200" visibility="hide">
<layer id="d2" width="200" height="200">
                                                <div id="descriptions" align="left" class="bluefnt">
                                                    <!--Change below to default content of your own-->
                                                    <font face="Verdana" color="#000000"></font>
                                                    <!--Stop editting-->
                                                </div>
                                                </layer>
</ilayer>
                                                
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

    <script language="javascript" type="text/javascript">
    
      GetToolTip() 
   
    </script>

    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
