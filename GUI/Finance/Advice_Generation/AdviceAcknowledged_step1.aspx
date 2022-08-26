<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="AdviceAcknowledged_step1.aspx.cs" Inherits="GUI_Finance_Advice_Generation_AdviceAcknowledged" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
<script language="javascript" type="text/javascript">
    var cal = new CalendarPopup("Div1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
    var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
    var client_name="<%=Session["Client"]%>"
	var FinYear="<%=Session["FinYear"]%>"
	var FinYear_to=parseInt(FinYear)+1
		
	if(FinYear_to<10)
	{
	FinYear_to="0"+FinYear_to
	}
	var FinYear_fromdate="01/04/"+FinYear
	var FinYear_todate="31/03/"+FinYear_to
	var Sle_finyear=FinYear+"-"+FinYear_to

function checksubmit1()
{
//    //debugger;
//    var adviceno = "ctl00_MyCPH1_txtAdviceNo";
//    var flag = false;
//    flag = Advicecheck(adviceno);
//    
//    //debugger;
//    if(flag)
//        return true;
//    else
//        return false;
}	
function CheckSubmit1()
{ 
    var txtAdviceNo = document.getElementById("ctl00_MyCPH1_txtAdviceNo");
    if(txtAdviceNo.value == "")
    {
        alert("Plz Enter Advice No");
        txtAdviceNo.focus();
        return false;
    }
    return true;
}
function Advicecheck(id)
{
    //debugger;
    var txt=document.getElementById(id);
    var flag = true;
    if(txt.value=="")
        return false;
    txt.value=txt.value.toUpperCase();
    
    var findobj=false;
    findobj=GetXMLHttpObject();
    
    if(findobj)
    {
     var strpg="AdviceCheckExist.aspx?adviceno=" + txt.value + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {      
                       var res=findobj.responseText.split("|");
                       if(res[0]=="N")
                       {
                            alert("Advice Is not Valid..Enter Proper Advice Code....");
                            txt.value="";
                            flag = false;
                       }
                       else if(res[3]!="SUBMITTED")
                       {
                            alert("Advice Is Already " +res[3]);
                            txt.value="";
                            flag = false;
                       }
                       else if(res[4]!="N")
                       {
                            alert("Advice Is Already Cancelled");
                            txt.value="";
                            flag = false;
                       }
                }
          }
        findobj.send(null);
    }
    return flag; 
}
function AdviceBlur(id)
{   
    var txt=document.getElementById(id);
    //var advdt=id.substring(0,id.length-11) + "lbladvdt";
    //var raisedon = id.substring(0,id.length-11) + "txtraisedon";
    
    if(txt.value=="")
        return false;
    txt.value=txt.value.toUpperCase();
    
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="AdviceCheckExist.aspx?adviceno=" + txt.value + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                       //debugger;
                       var res=findobj.responseText.split("|");
                       if(res[0]=="N")
                       {
                            alert("Advice Is not Valid..Enter Proper Advice Code....");
                            txt.value="";
                            return false;
                       }
                       else if(res[3]!="SUBMITTED")
                       {
                            alert("Advice Is Already " +res[3]);
                            txt.value="";
                            return false;
                       }
                       else if(res[4]!="N")
                       {
                            alert("Advice Is Already Cancelled");
                            txt.value="";
                            return false;
                       }
                       else
                       {
                            return true;
                            //document.getElementById(advdt).innerText = res[1]
                            //document.getElementById(raisedon).value = res[2]
                       }//obj.innerText

                }
          }
        findobj.send(null);
    }
}
</script>	
<div style="width: 10.0in; text-align: right">
    <a href="javascript:window.history.go(-1)" title="back">
    <img alt="back" src="../../images/back.gif" border="0" /></a>
</div>
<div style="text-align: center; width: 10.0in">
    <table cellspacing="1" class="boxbg" width="800">
        <tr class="bgbluegrey">
            <td align="center" style="text-align: left; height: 20px;">
                <strong>Advice Acknowledgement</strong>
            </td>
        </tr>
    </table>
    <br />
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                        <tr>
                            <td align="right"><img src="../../images/loading.gif" alt="" /></td>
                            <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                        </tr>
                    </table>
                    <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF;
                        width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                        runat="server">
                        <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                            left: 50%;" ID="Panel2" runat="server">
                        </asp:Panel>
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
    <br />      
    <asp:UpdatePanel ID="UpdatePanel3" runat="server"    UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
                <tr class="bgbluegrey">
                    <td align="center" colspan="4">
                        <strong>Search Criteria</strong>
                    </td>
                </tr>
                <tr style="background-color: White"> 
                    <td width="151" class="blackfnt" nowrap style="text-align: left; width: 151px;"> 
                        &nbsp;Advice No</td>
                    <td width="151" class="blackfnt" style="text-align: left">
                        <asp:TextBox ID="txtAdviceNo" runat="server"></asp:TextBox>
                    </td>
                    <td width="151" class="blackfnt" style="text-align: left">
                        <%--<asp:Button ID="adv_submit_1" runat="server" OnClick="adv_submitclick_1" OnClientClick="javascript:return checksubmit1()" Text="Submit" />--%>
                        <asp:Button ID="adv_submit_1" runat="server" OnClick="adv_submitclick_1" OnClientClick="return CheckSubmit1()" Text="Submit" />
                    </td>
                </tr>
                <tr style="background-color: White"> 
                    <td class="blackfnt" colspan="4"><strong>OR</strong></td>
                </tr>
                <tr style="background-color: White"> 
                        <td valign="top" width="20%" >
                            <asp:Label ID="lblDateRange1" CssClass="blackfnt" runat="server" Font-Bold="True">Select Date</asp:Label>
                        </td>
                        <td align="left" valign="top">
                            <asp:UpdatePanel ID="UpdatePanel1"   UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="radDate" runat="server" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_OnSelectedIndexChange" >
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="1" Text=" Today:"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="2" Text=" Last Week (Including Today)"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                        <td valign="top" align="left" >
                            <asp:UpdatePanel ID="UpdatePanel2" RenderMode="Inline"  UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox CssClass="input" ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="76px" BorderStyle="Groove"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor11','dd/MM/yyyy'); return false;" id="a1" name="anchor11">
                                        <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox CssClass="input" ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="76px" BorderStyle="Groove"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor12','dd/MM/yyyy'); return false;" id="a2" name="anchor12">
                                        <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom" CssClass="blackfnt"
                                        ErrorMessage="Date From cannot be blank :(" ValidationGroup="VGDtFromTo" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                                        ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                                        ErrorMessage="Date To cannot be blank :(" ValidationGroup="VGDtFromTo" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date To  :(" CssClass="blackfnt"
                                        ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                   </tr>
                   <tr style="background-color: White"> 
                     <td class="blackfnt" colspan="4">
                        <asp:Button ID="adv_submit_2" runat="server" OnClick="adv_submitclick_2" Text="Submit" ValidationGroup="VGDtFromTo" />
                     </td>
                   </tr>     
            </table>   
            <div id="Div1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;"></div>    
        </ContentTemplate>
    </asp:UpdatePanel>
</div>        
</asp:Content>

