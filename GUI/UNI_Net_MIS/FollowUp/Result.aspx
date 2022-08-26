<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_FollowUp_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="JavaScript" type="text/javascript">
    
    	function DrillDown(Fromdt,todt,loc,cust,rpt,rptmd)
			{	
				/*document.form1.action = "Result_Det.aspx?Fromdt=" + Fromdt +"&todt=" + todt +"&loc=" + loc +"&cust=" + cust +"&rpt=" + rpt +"&rptmd="+rptmd;// ",";
				document.form1.target = "_self";
				document.form1.submit();*/
				
				var strPopupURL = "Result_Det.aspx?Fromdt=" + Fromdt +"&todt=" + todt +"&loc=" + loc +"&cust=" + cust +"&rpt=" + rpt +"&rptmd="+rptmd;// ",";
							
				winNew = window.open(strPopupURL, "_self")
				
			}
    
    </script>
    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                        class="blklnkund"><strong>Finance </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Cash Income Management</strong> </font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="./../../images/clear.gif" width="2" height="1" /></td>
        </tr>
        <tr>
            <td align="right">
                <div align="center">
                    <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                        <ProgressTemplate>
                            <div id="progressArea">
                                <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </div>
                <a href="javascript:window.history.go(-1)" title="back">
                    <img alt="Back" src="./../../images/back.gif" border="0" />
                </a>
            </td>
        </tr>
        <tr>
            <td>
                <table border="0" runat="server" id="TBL_CRI"   horizontalalign="left" cellpadding="3" cellspacing="1" style="width: 7.0in;"
                    class="boxbg">
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Date</td>
                        <td>
                            <asp:Label runat="server" ID="LBLDATE"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            RO</td>
                        <td>
                            <asp:Label runat="server" ID="LBLBRANCH"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Location</td>
                        <td>
                            <asp:Label runat="server" ID="LBLRPT"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Customer</td>
                        <td>
                            <asp:Label runat="server" ID="lblGrp"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                          Collection  Type </td>
                        <td>
                            <asp:Label runat="server" ID="lbltypBill"></asp:Label></td>
                    </tr>
                    
                    
                </table>
            </td>
        </tr>
        <tr>
            <td valign="top"><br />
                
                            <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                        
            </td>
        </tr>
        <tr>
            <td valign="top">
                <br />
                <asp:Table id="TBL_CF"  Visible="false"   border="0" HorizontalAlign="left" runat="server" CellPadding="3" CellSpacing="1" style="width:8.5in; border:1" CssClass="boxbg"></asp:Table>
                
            </td>
        </tr>
        <tr>
            <td valign="top"><br />
                
                            <asp:Button ID="Button2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                        
            </td>
        </tr>
    </table>
</asp:Content>
