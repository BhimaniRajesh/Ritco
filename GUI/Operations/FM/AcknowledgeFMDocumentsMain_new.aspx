<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="AcknowledgeFMDocumentsMain_new.aspx.cs" Inherits="GUI_Operations_FM_AcknowledgeFMDocumentsMain_new" %>
    
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="JavaScript" src="../../Images/CalendarPopup.js"></script>
    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script type="text/javascript" language="JavaScript">
        var cal = new CalendarPopup("testdiv1"); 
	        cal.setCssPrefix("TEST");
	        cal.showNavigationDropdowns();        	
        	
        function ValidateData()
        {
            var ddlDocType=document.getElementById("ctl00_MyCPH1_ddlDocType");
	         if(ddlDocType.value=="")
	        {
		        alert("Please Select Doc Type!!!")
		        ddlDocType.focus();
		        return false;
	        }
	        return DateCheck();
        }	
        
    </script>
    
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank" style="border: 0px; position: absolute;
                z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth);
                height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
            </iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please
                    Wait...</b></font></div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module </strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>Administrator </strong></font><strong>&gt; </strong>
                <font class="blklnkund"><strong>Operations </strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>DFM </strong></font><strong>&gt; </strong>
                <font class="bluefnt"><strong>Acknowledge Receipt</strong></font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr>
            <td>
                <img src="../../images/clear.gif" width="15" height="10" /></td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td height="300" valign="top">
                <!--START-->
                <center>
                    <br />
                    <table border="0" class="boxbg" cellspacing="1" cellpadding="1" style="width: 8.5in">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4" style="height: 20px;">
                                <label class="blackfnt">
                                    <b>FM Query </b>
                                </label>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="left" style="width: 17%">
                                <label class="blackfnt">
                                    Select FM Type:
                                </label>
                            </td>
                            <td align="left" colspan="3">
                                <asp:DropDownList ID="ddlDocType" runat="server" CssClass="input" ></asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="left" style="width: 17%">
                                <label class="blackfnt">
                                    FM Forwarded To:
                                </label>
                            </td>
                            <td align="left" colspan="3">
                                <asp:DropDownList ID="ddlFwdDocTo" runat="server" CssClass="input">
                                    <asp:ListItem Value="" Selected="True" Text="Select"></asp:ListItem>
                                    <asp:ListItem Value="Customer" Text="Customer"></asp:ListItem>
                                    <asp:ListItem Value="Location" Text="Location"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr bgcolor="White">
                            <td valign="top" align="left">
                                <font class="blackfnt">Select Date:</font>
                            </td>
                            <td align="left">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="center" colspan="4">
                                <label class="blackfnt">
                                    <b>OR </b>
                                </label>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td align="left" style="width: 17%">
                                <label class="blackfnt">
                                    Enter FM No.(s):
                                </label>
                            </td>
                            <td align="left" colspan="3">
                                <asp:TextBox ID="txtFMNo" size="45" runat="server"></asp:TextBox>
                                <label class="blackfnt">
                                    (<i>Seperated by Comma if multiple. e.g PFMLKO07002,PFMLKO07003 </i>)
                                </label>
                            </td>
                        </tr>                        
                        <tr style="background-color: White">
                            <td align="right" colspan="4">
                                <asp:UpdatePanel ID="upSubmit" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" OnClientClick="return ValidateData()" />
                                        <label class="blackfnt">
                                            &nbsp;&nbsp;
                                        </label>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </center>
                <br />
                <asp:UpdatePanel ID="u1"  UpdateMode="Conditional" runat="server">
                    <ContentTemplate>                        
                        <asp:GridView align="center" ID="dgDocket" runat="server" CellSpacing="1" CellPadding="2" Width="9.0in" GridLines="None"
                            HeaderStyle-HorizontalAlign="Center" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true" 
                            PagerStyle-HorizontalAlign="Center" CssClass="boxbg" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                            AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                            EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO.">
                                    <ItemTemplate>
                                        <asp:Label  CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                            runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="blackfnt" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="PFM No" ItemStyle-HorizontalAlign="Center"  HeaderStyle-HorizontalAlign="center" HeaderStyle-CssClass="blackfnt" 
                                    ItemStyle-BackColor="white">
                                    <ItemTemplate  >
                                        <label  class="blackfnt">
                                            <asp:HyperLink  runat="server" Font-Underline="True" CssClass="blackfnt" NavigateUrl='<%#"AcknowledgeFMDocumentsMain_Det_new.aspx?FMN=" +DataBinder.Eval(Container.DataItem, "fm_no") + "~"+DataBinder.Eval(Container.DataItem, "fm_doc_type")   %>'
                                                Text='<%# DataBinder.Eval( Container.DataItem,"fm_no") %>' ID="Hyperlink1">
                                            </asp:HyperLink>
                                        </label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="pfmdt" HeaderText="PFM Date">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="from_to" HeaderText="From - TO">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle  HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Total_Documents" HeaderText="Total Doc.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:BoundField DataField="fm_ack_status" HeaderText="Ack Status">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                            </Columns>
                            <RowStyle BackColor="white" />
                            <AlternatingRowStyle BackColor="#f7f7f7" />
                            <PagerStyle HorizontalAlign="Center" BackColor="white" />
                            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                            <FooterStyle CssClass="boxbg" />
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
                <br />
                <br />
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
