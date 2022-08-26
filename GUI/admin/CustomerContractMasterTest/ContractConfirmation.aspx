<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ContractConfirmation.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_ContractConfirmation"
    Title="Untitled Page" %>
<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo" TagPrefix="cust" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript">
    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	 function btnstep1()
	 {
	        var txtfrom=document.getElementById("ctl00_MyCPH1_txtfrom");
	        var txtto=document.getElementById("ctl00_MyCPH1_txtto");
	        
	        if(txtfrom.value=="")
	        {
	            alert("Please Enter From date.....");
	            txtfrom.focus();
	            return false;
	        }
	        
	        if(txtto.value=="")
	        {
	            alert("Please Enter To date.....");
	            txtfrom.focus();
	            return false;
	        }
	        
	        if(!isValidDate(txtfrom.value,"Contract Effective"))
	        {
	            txtfrom.value="";
	            txtfrom.focus();
	            return false;
	        }
	        
	        if(!isValidDate(txtto.value,"Contract End "))
	        {
	            txtto.value="";
	            txtto.focus();
	            return false;
	        }
	    
	        if(!confirm("Are you sure you want to change date Range ??"))
	            return false;
	            
	    return true;
	 }
	 
     function btnnext()
     {     
        var btnsubmit = document.getElementById("ctl00_MyCPH1_btnsubmit");
        var btnsubmit1 = document.getElementById("ctl00_MyCPH1_btnsubmit1");
        btnsubmit.style.display="none";
        btnsubmit.style.display="block";
        return true;
     }         
            
    </script>


    <asp:UpdatePanel ID="updone" runat="server">
        <ContentTemplate>
            <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
                z-index: 99;">
            </div>
            <asp:Panel runat="server" Width="10in" ID="divmain">
                 <cust:CustInfo runat="server" ID="cstheader" />
                <asp:Table runat="server" HorizontalAlign="Center" CellSpacing="1" CssClass="boxbg"
                    Width="50%">
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell Font-Bold="true" ColumnSpan="2">Contract Confirmation</asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite" ID="trlblconfirm" runat="server">
                        <asp:TableCell Font-Bold="true" ColumnSpan="2">
                            <asp:Label ID="lbldesc" runat="server" CssClass="blackfnt"></asp:Label>&nbsp;&nbsp;
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite" ID="troptconfirm" runat="server">
                        <asp:TableCell Font-Bold="true" ColumnSpan="2">
                            <asp:RadioButtonList ID="optyesno" RepeatDirection="Horizontal" runat="server">
                                <asp:ListItem Value="Y" Text="Yes"></asp:ListItem>
                                <asp:ListItem Value="N" Text="No"></asp:ListItem>
                            </asp:RadioButtonList>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite" ID="trlbldateerror" runat="server">
                        <asp:TableCell ColumnSpan="2">
                            <asp:Label ID="lbldateerror" runat="server" CssClass="blackfnt"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow ID="trlbldates" runat="server" CssClass="bgwhite">
                        <asp:TableCell Font-Bold="true">
                    Contract Effective Date
                        </asp:TableCell>
                        <asp:TableCell Font-Bold="true">
                    Contract End Date
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite" ID="trtxtdates" runat="server">
                        <asp:TableCell Font-Bold="true">
                            <asp:TextBox ID="txtfrom" runat="server" Width="70px" MaxLength="10" CssClass="blackfnt"
                                BorderStyle="Groove" >
                            </asp:TextBox>
                            <asp:Label ID="lbldockdateimage" runat="server">
                            <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtfrom,'ancfrom','dd/MM/yyyy'); return false;"
                                name="ancfrom" id="ancfrom">
                                <img src="../../images/calendar.jpg" alt="calendar.jpg"
                                    border="0" />
                            </a>
                            </asp:Label>
                        </asp:TableCell>
                        <asp:TableCell Font-Bold="true">
                            <asp:TextBox ID="txtto" runat="server" Width="70px" MaxLength="10" CssClass="blackfnt"
                                BorderStyle="Groove" >
                            </asp:TextBox>
                            <asp:Label ID="Label1" runat="server">
                            <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtto,'ancto','dd/MM/yyyy'); return false;"
                                name="ancto" id="ancto">
                                <img src="../../images/calendar.jpg" alt="calendar.jpg"
                                    border="0" />
                            </a>
                            </asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgbluegrey" ID="trstep1" runat="server">
                        <asp:TableCell HorizontalAlign="Right" ColumnSpan="2">
                            <asp:Button ID="btnstep1" CssClass="blackfnt" OnClientClick="javascript:return btnstep1()"
                                OnClick="btnstep1_Click" runat="server" Text="Change Dates" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgbluegrey" ID="trsubmit" runat="server">
                        <asp:TableCell HorizontalAlign="Right" ColumnSpan="2">
                            <asp:Button ID="btnsubmit" CssClass="blackfnt" OnClientClick="javascript:return btnnext()"
                                OnClick="btnsubmit_Click" runat="server" Text="Submit" />
                            <asp:Button ID="btnsubmit1" CssClass="blackfnt" Enabled="false" Style="display: none;"
                                runat="server" Text="Submit" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
            <asp:Panel runat="server" Width="10in" ID="divcomplete">
                <asp:Label ID="lblfeedback" runat="server" Font-Bold="true" CssClass="blackfnt"></asp:Label>
                <br />
                <br />
                <asp:Label ID="lblmorecontracts" runat="server" Font-Bold="true" CssClass="blackfnt"></asp:Label>
                <asp:HiddenField ID="hdnactive" runat="server" />
                <asp:HiddenField ID="hdncontractid" runat="server" />
                <asp:HiddenField ID="hdncustcode" runat="server" />
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
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
</asp:Content>
