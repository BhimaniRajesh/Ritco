<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="ImportEnrouteStatusUpdateFromXLS_THCVehicle.aspx.cs" Inherits="GUI_Operations_Enroute_Status_Update_ImportEnrouteStatusUpdateFromXLS_THCVehicle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

        function btnSubmitCheck() {
            var FileUploader = document.getElementById("ctl00_MyCPH1_FileUploader");
            var lblMsg = document.getElementById("ctl00_MyCPH1_lblMsg");
            var pnlGrid = document.getElementById("ctl00_MyCPH1_pnlGrid");
            if (FileUploader.value == "") {
                alert("Please browse file to upload.");
                lblMsg.innerText = "";
                FileUploader.focus();
                pnlGrid.style.display = "none";
                return false;
            }
        }

        function showHideHelp(oEvent) {
            var oDiv = document.getElementById("helpDiv");
            if (oDiv.style.visibility == "hidden")
                showTipz(oEvent);
            else
                hideTipz(oEvent);
        }

        function showTipz(oEvent) {
            var oDiv = document.getElementById("helpDiv");
            oDiv.style.visibility = "visible";
            oDiv.style.left = oEvent.clientX + 5;
            oDiv.style.top = oEvent.clientY + 5;
        }

        function hideTipz(oEvent) {
            var oDiv = document.getElementById("helpDiv");
            oDiv.style.visibility = "hidden";
        }
    </script>

    <br />
    <br />
    <asp:Panel ID="pnlmain" runat="server" Width="9in">
        <table border="0" cellpadding="1" cellspacing="1" style="width: 100%">
            <tr>
                <td>
                    <table border="0" cellpadding="1" cellspacing="1" class="boxbg">
                        <tr class="bgbluegrey">
                            <td class="blackfnt" align="center" colspan="2">
                                <b>Enroute Status Update Via XLS - <%=SessionUtilities.THCCalledAs.ToString() %> / Vehicle</b>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td>
                                Select File :
                            </td>
                            <td>
                                <asp:FileUpload ID="FileUploader" runat="server" CssClass="ltxt" Style="width: 300px" />
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="center" colspan="2">
                                <asp:Button ID="btnImport" runat="server" Text="Import" CssClass="fbtn" OnClientClick="javascript:return btnSubmitCheck()"
                                    OnClick="btnImport_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height: 20px">
                </td>
            </tr>
            <tr>
                <td align="left">
                    <asp:Label ID="lblMsg" ForeColor="red" Font-Bold="true" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <div class="blackfnt">
        <table>
            <tr>
                <td valign="middle">
                    For the help regarding XLS format. Click here&nbsp;
                </td>
                <td>
                    <span onclick="showHideHelp(event)" onmouseover="this.style.cursor = 'hand';" onmouseout="this.style.cursor = 'auto';">
                        <img src="../../images/help.png" alt="Help" /></span>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <br />
    <div id="helpDiv" style="position: absolute; background-color: #ffffcc; visibility: hidden;
        padding-right: 7px; padding-left: 7px; padding-bottom: 1px; padding-top: 1px;
        margin: 2px 5px; border: solid black 1px;">
        <br />
        <div class="blackfnt">
            <b>Sample format for Enroute Status Update..</b>
            <br />
            Keep Data in <b>Sheet1</b> Only.
            <br />
            Entire Data/Sheet must be in <b>Test Format</b> Only.
            <br />
            <br />
            <table border="0" cellpadding="3" cellspacing="1" class="boxbg">
                <tr class="bgbluegrey">
                    <td align="center" valign="top">
                        <b>VendorCode</b>
                    </td>
                    <td align="center" valign="top">
                        <b><%=SessionUtilities.THCCalledAs.ToString() %>No</b>
                    </td>
                    <td align="center" valign="top">
                        <b>VehicleNo</b>
                    </td>
                    <td align="center" valign="top">
                        <b>Date</b>
                    </td>
                    <td align="center" valign="top">
                        <b>Hour</b>
                    </td>
                    <td align="center" valign="top">
                        <b>Minute</b>
                    </td>
                    <td align="center" valign="top">
                        <b>Location</b>
                    </td>
                    <td align="center" valign="top">
                        <b>Remarks</b>
                    </td>
                    <td align="center" valign="top">
                        <b>MovementStatus</b>
                    </td>
                    <td align="center" valign="top">
                        <b>AwaitingAction</b>
                    </td>
                    <td align="center" valign="top">
                        <b>DaysSinceLastActon</b>
                    </td>
                </tr>
                <tr bgcolor="#ffffcc" align="center">
                    <td>
                        HANDOVER
                    </td>
                    <td>
                        VH/AMDB/09_10/00009
                    </td>
                    <td>
                        RJ14GA2422
                    </td>
                    <td>
                        13/08/2010
                    </td>
                    <td>
                        12
                    </td>
                    <td>
                        01
                    </td>
                    <td>
                        Location1
                    </td>
                    <td>
                        Remark1
                    </td>
                    <td>
                        Stationery
                    </td>
                    <td>
                        Loading
                    </td>
                    <td>
                        5
                    </td>
                    
                </tr>
                <tr bgcolor="#ffffcc" align="center">
                    <td>
                        622653
                    </td>
                    <td>
                        VH/AMDB/09_10/00161
                    </td>
                    <td>
                        GJ1AT3604
                    </td>
                    <td>
                        11/08/2010
                    </td>
                    <td>
                        09
                    </td>
                    <td>
                        25
                    </td>
                    <td>
                        Location2
                    </td>
                    <td>
                        Remark2
                    </td>
                    <td>
                        In-transit
                    </td>
                    <td>
                        Loading
                    </td>
                    <td>
                        10
                    </td>                    
                </tr>
                <tr bgcolor="#ffffcc" align="center">
                    <td>
                        320744
                    </td>
                    <td>
                        VH/AMDH/09_10/00007
                    </td>
                    <td>
                        GJ1AZ8409
                    </td>
                    <td>
                        05/08/2010
                    </td>
                    <td>
                        12
                    </td>
                    <td>
                        01
                    </td>
                    <td>
                        Location3
                    </td>
                    <td>
                        Remark3
                    </td>
                    <td>
                        Stationery
                    </td>
                    <td>
                        Unloading
                    </td>
                    <td>
                        7
                    </td>                    
                </tr>
            </table>
        </div>
        <br />
    </div>
    <asp:Panel ID="pnlGrid" Visible="false" runat="server" Width="9in">
        <br />
        <br />
        <asp:Table runat="server" Width="9in" ID="Table1">
            <%--<asp:TableRow CssClass="nrow">
                <asp:TableCell CssClass="blackfnt" HorizontalAlign="Right">
                    <asp:LinkButton ID="lnkBtnDownloadXLS" runat="server" CssClass="blackfnt" OnClick="lnkBtnDownloadXLS_Click">Download XLS</asp:LinkButton>
                </asp:TableCell>
            </asp:TableRow>--%>
            <asp:TableRow CssClass="nrow">
                <asp:TableCell HorizontalAlign="Center" Font-Bold="true">
                        Invalid Records
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:Table runat="server" Width="9in" ID="tblClose">
            <asp:TableRow Height="50px">
                <asp:TableCell VerticalAlign="Top" HorizontalAlign="Center">
                    <asp:GridView ID="gvInvalid" runat="server" CellSpacing="1" Border="0" HeaderStyle-CssClass="bgbluegrey"
                        AllowPaging="false" PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="boxbg"
                        HeaderStyle-Height="24px" AutoGenerateColumns="false" EmptyDataText="No Records Found..."
                        Width="100%">
                        <Columns>
                            <asp:TemplateField HeaderText="SRNo." ControlStyle-CssClass="blackfnt">
                                <HeaderStyle HorizontalAlign="Center" Width="30" />
                                <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server" CssClass="blackfnt">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField> 
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center>
                                        <asp:Label ID="lbl1" runat="server" Text="Vendor Code"></asp:Label>
                                    </center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblVendorCode" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "VendorCode")%>'
                                        CssClass="blackfnt" Font-Underline="false" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Wrap="false"/>
                                <ItemStyle BackColor="white" CssClass="blackfnt" Wrap="false" HorizontalAlign="Center" />
                            </asp:TemplateField>                            
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center>
                                        <asp:Label ID="lbl2" runat="server" Text='<%#SessionUtilities.THCCalledAs +" No"%>'></asp:Label>
                                    </center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblDockNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "THCNo")%>'
                                        CssClass="blackfnt" Font-Underline="false" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Wrap="false"/>
                                <ItemStyle BackColor="white" CssClass="blackfnt" Wrap="false" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center>
                                        <asp:Label ID="lbl3" runat="server" Text="Vehicle No"></asp:Label>
                                    </center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblVehicleNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "VehicleNo")%>'
                                        CssClass="blackfnt" Font-Underline="false" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Wrap="false"/>
                                <ItemStyle BackColor="white" CssClass="blackfnt" Wrap="true" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center>
                                        <asp:Label ID="lbl4" runat="server" Text="Date"></asp:Label>
                                    </center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblDockDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Date")%>'
                                        CssClass="blackfnt" Font-Underline="false" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Wrap="false"/>
                                <ItemStyle BackColor="white" CssClass="blackfnt" Wrap="true" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center>
                                        <asp:Label ID="lbl5" runat="server" Text="Hour"></asp:Label>
                                    </center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblHour" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Hour")%>'
                                        CssClass="blackfnt" Font-Underline="false" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Wrap="false"/>
                                <ItemStyle BackColor="white" CssClass="blackfnt" Wrap="false" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center>
                                        <asp:Label ID="lbl6" runat="server" Text="Minute"></asp:Label>
                                    </center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblMinute" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Minute")%>'
                                        CssClass="blackfnt" Font-Underline="false" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Wrap="false"/>
                                <ItemStyle BackColor="white" CssClass="blackfnt" Wrap="false" HorizontalAlign="Center" />
                            </asp:TemplateField>                            
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center>
                                        <asp:Label ID="lbl7" runat="server" Text="Location"></asp:Label>
                                    </center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblLocation" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Location")%>'
                                        CssClass="blackfnt" Font-Underline="false" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Wrap="false"/>
                                <ItemStyle BackColor="white" CssClass="blackfnt" Wrap="true" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center>
                                        <asp:Label ID="lbl8" runat="server" Text="Remarks"></asp:Label>
                                    </center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblRemarks" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Remarks")%>'
                                        CssClass="blackfnt" Font-Underline="false" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Wrap="false"/>
                                <ItemStyle BackColor="white" CssClass="blackfnt" Wrap="true" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center>
                                        <asp:Label ID="lbl9" runat="server" Text="Movement Status"></asp:Label>
                                    </center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblMovementStatus" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "MovementStatus")%>'
                                        CssClass="blackfnt" Font-Underline="false" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Wrap="false"/>
                                <ItemStyle BackColor="white" CssClass="blackfnt" Wrap="true" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center>
                                        <asp:Label ID="lbl10" runat="server" Text="Awaiting Action"></asp:Label>
                                    </center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblAwaitingAction" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "AwaitingAction")%>'
                                        CssClass="blackfnt" Font-Underline="false" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Wrap="false"/>
                                <ItemStyle BackColor="white" CssClass="blackfnt" Wrap="true" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center>
                                        <asp:Label ID="lbl11" runat="server" Text="Days Since Last Acton"></asp:Label>
                                    </center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblDays" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Days")%>'
                                        CssClass="blackfnt" Font-Underline="false" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Wrap="false"/>
                                <ItemStyle BackColor="white" CssClass="blackfnt" Wrap="true" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <center>
                                        <asp:Label ID="lbl12" runat="server" Text="Error Message"></asp:Label>
                                    </center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblErrorMessage" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ErrorMessage")%>'
                                        CssClass="blackfnt" Font-Underline="false" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" Wrap="false"/>
                                <ItemStyle BackColor="white" CssClass="blackfnt" Wrap="false" HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="bgbluegrey" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:Table runat="server" Width="9in" ID="Table2">
            <%--<asp:TableRow CssClass="nrow">
                <asp:TableCell CssClass="blackfnt" HorizontalAlign="Right">
                    <asp:LinkButton ID="lnkBtnDownloadXLS1" runat="server" CssClass="blackfnt" OnClick="lnkBtnDownloadXLS_Click">Download XLS</asp:LinkButton></asp:TableCell>
            </asp:TableRow>--%>
        </asp:Table>
        <br />
    </asp:Panel>
</asp:Content>
