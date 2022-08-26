<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatrixSelection.aspx.cs" Inherits="GUI_AllTest_MatrixSelection" Title="Untitled Page" %>

<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo"
    TagPrefix="cust" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript">
        function btnnext()
        {
             //var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
             //var hdnservicecode=document.getElementById("ctl00_MyCPH1_hdnservicecode");
             
             //if(hdnajaxstate.value=="1")
             //{
             //   alert("Let the Internal Proccesses over. Please wait or LogOn Again");
             //   return false;
             //}
             
             //var txtfrom=document.getElementById("ctl00_MyCPH1_txtfrom");
             //var txtto=document.getElementById("ctl00_MyCPH1_txtto");
             //if(hdnservicecode.value=="3.1")
             //{
             //   if(txtfrom.value=="")
             //   {
             //       alert("Please Enter From Location");
             //       txtfrom.focus();
             //       return false;
             //   }
             //}
             //else
             //{
             //    if(txtfrom.value=="" && txtto.value=="")
             //    {
             //       alert("Please Enter From or To");
             //       txtfrom.focus();
             //       return false;
             //    }
             //}
             //if(hdnservicecode.value=="2.1")
             //{
             //    if(txtto.value=="")
             //    {
             //       alert("Please Enter To location");
             //       txtto.focus();
             //       return false;
             //    }
             //    if(txtfrom.value=="" )
             //    {
             //       alert("Please Enter From Location");
             //       txtfrom.focus();
             //       return false;
             //    }
             //}
             return true;
        }   

function windowPopUp(mode,ctlid,tbl)
{
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl + "&tp=4row";
    confirmWin=window.open(url,"",winOpts);
    return false;
}

        
function locTest(txtid,testtype)
{
    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
	    hdnajaxstate.value="1";

    var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
    var txt=document.getElementById(txtid);
    if(txt.value=="") 
    {   
        hdnajaxstate.value="0";
        return false;
    }
   
    txt.value=txt.value.toUpperCase();
    var strpg="";
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
         if(testtype=="citytest")
            strpg="AjaxResponse.aspx?mode=check&code1=citytest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
         else if(testtype=="loctest")
             strpg="AjaxResponse.aspx?mode=check&code1=loctest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
         else if(testtype=="zonetest")
             strpg="AjaxResponse.aspx?mode=check&code1=zonetest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();

     findobj.open("GET",strpg);
     findobj.onreadystatechange=function()
         {
             if((findobj.readyState==4) && (findobj.status==200))
                {
                      var res=findobj.responseText.split("|");
                      if(res[0]=="false")
                         {
                            if(testtype=="citytest")
                                alert("City doesn't Exists...");
                            else if(testtype=="loctest")
                                alert("Location doesn't Exists...");
                            else if(testtype=="zonetest")
                                alert("Region doesn't Exists...");
                            txt.value="";
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
    </script>

    <asp:UpdatePanel runat="server" ID="updone">
        <ContentTemplate>
            <asp:Panel Width="10in" runat="server" HorizontalAlign="Center">
                <asp:Table runat="server" Width="100%">
                    <asp:TableRow>
                        <asp:TableCell HorizontalAlign="Left">
                            <cust:CustInfo runat="server" ID="cstheader" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <br />
                            <asp:Table ID="Table2" runat="server" Width="60%" CssClass="boxbg" CellSpacing="1">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell HorizontalAlign="Center" ColumnSpan="2" Font-Bold="true">Select Rate Matrix to be Edited</asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow HorizontalAlign="Left" CssClass="bgwhite">
                                    <asp:TableCell>Name</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblname" runat="server" Font-Bold="true" CssClass="blackfnt"></asp:Label>&nbsp;
                                        <asp:Label ID="lblinstance" runat="server" CssClass="blackfnt"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow HorizontalAlign="Left" CssClass="bgwhite">
                                    <asp:TableCell>Select Matrix Type</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="cmbmatrixtype" runat="server" BackColor="White" CssClass="blackfnt"
                                            AutoPostBack="true" OnSelectedIndexChanged="cmbmatrixtype_SelectedIndexChanged">
                                            <asp:ListItem Text="City - City" Value="C"></asp:ListItem>
                                            <asp:ListItem Text="Location - Location" Value="L"></asp:ListItem>
                                            <asp:ListItem Text="Region - Region" Value="R"></asp:ListItem>
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow HorizontalAlign="Left" CssClass="bgwhite">
                                    <asp:TableCell>Transport Mode</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="cmbtransmode" runat="server" DataTextField="codedesc" DataValueField="codeid"
                                            BackColor="White" CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trbasedon1" runat="server" style="display:none;" HorizontalAlign="Left" CssClass="bgwhite">
                                    <asp:TableCell>Business Type </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="ddlbasecode1" runat="server" OnSelectedIndexChanged="ddlbasecode1_SelectedIndexChanged" AutoPostBack="true" DataTextField="codedesc" DataValueField="codeid"
                                            BackColor="White" CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trbasedon2" runat="server" style="display:none;" HorizontalAlign="Left" CssClass="bgwhite">
                                    <asp:TableCell>Product Type </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="ddlbasecode2" runat="server" DataTextField="codedesc" DataValueField="codeid"
                                            BackColor="White" CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trfrom" runat="server" HorizontalAlign="Left" CssClass="bgwhite">
                                    <asp:TableCell>
                                        <asp:Label ID="lblfrom" runat="server" CssClass="blackfnt">From</asp:Label></asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtfrom" CssClass="blackfnt" Width="50px" onblur="this.value=this.value.toUpperCase()"
                                            BorderStyle="groove" MaxLength="50" runat="server"></asp:TextBox>
                                        <asp:Button ID="btnfrom" runat="server" CssClass="blackfnt" Text="...." />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trto" runat="server" HorizontalAlign="Left" CssClass="bgwhite">
                                    <asp:TableCell>
                                        <asp:Label ID="lblto" runat="server" CssClass="blackfnt">To</asp:Label></asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtto" CssClass="blackfnt" Width="50px" onblur="this.value=this.value.toUpperCase()"
                                            BorderStyle="groove" MaxLength="50" runat="server"></asp:TextBox>
                                        <asp:Button ID="btnto" runat="server" CssClass="blackfnt" Text="...." />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell HorizontalAlign="Right" ColumnSpan="2">
                                        <asp:Button ID="btnnext" Text="Next >>" CssClass="blackfnt" runat="server" ToolTip="Click here to edit contract details for the selected customer"
                                            OnClientClick="javascript:return btnnext();" OnClick="btnnext_Click" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
            <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
            <asp:HiddenField ID="hdnservicecode" runat="server" />
            <asp:HiddenField ID="hdncontractid" runat="server" />
            <asp:HiddenField ID="hdncustcode" runat="server" />
            <asp:HiddenField ID="hdnchargecode" runat="server" />
            <asp:HiddenField ID="hdnchargetype" runat="server" />
            <asp:HiddenField ID="hdnbasedon1" runat="server" />
            <asp:HiddenField ID="hdnbasecode1" runat="server" />
            <asp:HiddenField ID="hdnbasedon2" runat="server" />
            <asp:HiddenField ID="hdnbasecode2" runat="server" />
            
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
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
