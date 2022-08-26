<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ContractConfirmation.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_ContractConfirmation"
    Title="Untitled Page" %>

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

    <br />
    <br />
    <asp:UpdatePanel ID="updone" runat="server">
        <ContentTemplate>
            <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
                z-index: 99;">
            </div>
            <asp:Panel runat="server" Width="10in" ID="divmain">
                <asp:Table ID="Table2" runat="server" CssClass="blackfnt">
                    <asp:TableRow BackColor="White">
                        <asp:TableCell>
				       &nbsp;ContractID  
                        </asp:TableCell>
                        <asp:TableCell>
                            :
                            <asp:Label ID="lblcontractid" runat="server" onmouseover="this.style.cursor='pointer'"
                                CssClass="redfnt" Font-Bold="true"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow BackColor="White">
                        <asp:TableCell>
				       &nbsp;Customer Code & Name &nbsp;
                        </asp:TableCell>
                        <asp:TableCell>
                            :
                            <asp:Label ID="lblcustcodename" runat="server" onmouseover="this.style.cursor='pointer'"
                                CssClass="blackfnt" Font-Bold="true"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <br />
                <br />
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
            <iframe frameborder="0" src="about:blank" style="border: 0px; position: absolute;
                z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth);
                height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=35, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
            </iframe>
            <div style="position: absolute; z-index: 10; border-color: #8ba0e5; border-width: thick;
                left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <table style="border: solid #8ba0e5 2px;" width="190px" cellpadding="0" bgcolor="white">
                    <tr>
                        <td align="right">
                            <img src="../../images/loading.gif" /></td>
                        <td>
                            <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                    </tr>
                </table>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Content>
