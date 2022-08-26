<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="DocketCancellation.aspx.cs" Inherits="GUI_Operation_DocketCancellation_DocketCancellation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <%--THIS TWO FILES ARE FOR CALENDAR CONTROL--%>

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
	
/*****************************************************************************************************************
                                THIS FUCNTION IS USED TO TEST VALID DOCKET NUMBER
*****************************************************************************************************************/
function dockNoTest(txtid)
{

    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
	    hdnajaxstate.value="1";


    var txt=document.getElementById(txtid);
    if(txt.value=="") 
    {   
        hdnajaxstate.value="0";
        return false;
    }
    
    txt.value=txt.value.toUpperCase();
    
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="AjaxResponse.aspx?mode=check&code1=freshdockno&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
     findobj.open("GET",strpg);
     findobj.onreadystatechange=function()
         {
             if((findobj.readyState==4) && (findobj.status==200))
                {
                   var res=findobj.responseText.split("|");
                      if(res[0]=="false")
                         {
                            alert(res[1]);
                            txt.value="";
                            txt.focus();
                            hdnajaxstate.value="0";
                            return false;
                         }
                      else if(res[0]=="true")
                      {
                        hdnajaxstate.value="0";
                      }
                }
         }
         
    findobj.send(null);
    }
    
   return true;
}

function submitClick()
{
    var txtdockno=document.getElementById("ctl00_MyCPH1_txtdockno");
    if(txtdockno.value=="")
    {
        alert("Please Enter <%=dkt_call %>  Number");
        return false;
    }
    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
    if(hdnajaxstate.value!="0")
    {
        alert("Let the internal processes over.Try after 5-10 seconds or Logout and further Login");
        return false;
    }
    return true;
}


    </script>
<br /><br /><br />
   <asp:Panel runat="server" HorizontalAlign="Center" style="width: 8in;">
        <asp:Table runat="server" CellSpacing="1" HorizontalAlign="Center" CellPadding="1" CssClass="boxbg" width="80%">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="Center" ColumnSpan="2">
                    <asp:Label ID="lblDateRange1" runat="server" Font-Bold="true" CssClass="blackfnt"  Width="144px"><%=dkt_call %> Cancellation</asp:Label>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow style="background-color: white">
                <asp:TableCell>
                    Enter <%=dkt_call %> Number
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left">
                    <asp:TextBox ID="txtdockno" BorderStyle="Groove" onblur="javascript:return dockNoTest(this.getAttribute('id'))" CssClass="blackfnt" MaxLength="10" runat="server"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                <asp:TableCell HorizontalAlign="center" ColumnSpan="2" BackColor="#ffffff">
                    <asp:Button ID="btnsubmit" Text="Submit" CssClass="blackfnt" OnClick="btnsubmit_Click"
                       OnClientClick="javascript:return submitClick()"  runat="server" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
   </asp:Panel>
   <asp:UpdateProgress ID="uppMain" runat="server">
                <ProgressTemplate>
                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%;
                            left: 40%;" width="190px" cellpadding="0"
                        bgcolor="white">
                        <tr>
                            <td align="right">
                                <img src="../../images/loading.gif" alt="" />
                            </td>
                            <td>
                                <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                            </td>
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
   <asp:HiddenField ID="hdnajaxstate" Value="0" runat="server" />
   <asp:HiddenField ID="hdnclient" Value="0" runat="server" />
   <asp:HiddenField ID="hdnpaybas" Value="0" runat="server" />
   <asp:HiddenField ID="hdnemployee" Value="0" runat="server" />
   <asp:HiddenField ID="hdndockyear" runat="server" />
   <asp:HiddenField ID="hdnfin_year" runat="server" />
   <asp:HiddenField ID="hdnfin_year_2d" runat="server" />
   
</asp:Content>
