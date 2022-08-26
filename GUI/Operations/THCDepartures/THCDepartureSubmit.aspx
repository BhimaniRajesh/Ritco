<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="THCDepartureSubmit.aspx.cs" Inherits="GUI_Operations_THC_THCDepartureSubmit"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:SqlDataSource ID="MySQLDataSource_MFAvailable" runat="server" SelectCommand="usp_MF_For_OutgoingTHC"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="thcno" QueryStringField="THCNO" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>

    <script src="../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    <script src="./Js/THC.js" language="javascript" type="text/javascript"></script>

    <script src="../../Js/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script src="../../Js/AssignValue.js" language="javascript" type="text/javascript"></script>

    <asp:UpdatePanel ID="upDepartures"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <table cellspacing="1" style="width: 900px">
                <tr style="background-color: white">
                    <td align="left" style="width: 50%">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">THC Departures:</asp:Label>
                        <hr align="center" size="1" color="#8ba0e5">
                    </td>
                    <td align="left">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </table>
            <table border="0" cellspacing="1" cellpadding="5" width="700px" class="boxbg" id="tblDepart"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="4" style="text-align: left">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="THC For Departure"
                            Font-Bold="true"></asp:Label>
                        <asp:HiddenField ID="hTHCNo" runat="server" EnableViewState="true" />
                        <asp:HiddenField ID="hATADate" runat="server" EnableViewState="true" />
                        <asp:HiddenField ID="hATATime" runat="server" EnableViewState="true" />
                        <asp:HiddenField ID="hBrCd" runat="server" EnableViewState="true" />
                        <%--                        <asp:HiddenField ID="hStockList" runat="server" EnableViewState="true" />
--%>
                        <asp:HiddenField ID="hXMLData" runat="server" EnableViewState="true" />
                        <asp:HiddenField runat="server" ID="hSysDate" />
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td style="text-align: left; width: 15%">
                        <font class="blackfnt">THC #:</font>
                    </td>
                    <td style="text-align: left; width: 35%">
                        <font class="bluefnt">
                            <%= THCNo%>
                        </font>
                    </td>
                    <td style="text-align: left; width: 15%">
                        <font class="blackfnt">THC Date:</font>
                    </td>
                    <td style="text-align: left; width: 35%">
                        <font class="bluefnt">
                            <%=THCDateStr %>
                        </font>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td style="text-align: left; width: 15%">
                        <font class="blackfnt">Route:</font>
                    </td>
                    <td style="text-align: left">
                        <font class="bluefnt">
                            <%=Route %>
                        </font>
                    </td>
                    <td style="text-align: left; width: 15%">
                        <font class="blackfnt">Vehicle #:</font>
                    </td>
                    <td style="text-align: left">
                        <font class="bluefnt">
                            <%=vehicleno%>
                        </font>
                    </td>
                </tr>
                <%--                <tr style="background-color:White">
                    <td style="text-align: left;width:15%">
                        <font class="blackfnt">Vendor:</font>
                    </td>
                    <td colspan="3" style="text-align: left">
                        <font class="blackfnt">&nbsp;</font>
                    </td>
                </tr>--%>
                <tr style="background-color: White">
                    <td style="text-align: left; width: 15%">
                        <font class="blackfnt">ATA:</font>
                    </td>
                    <td style="text-align: left">
                        <font class="bluefnt">
                            <%=ATADate + " " + ATATime%>
                        </font><font class="blackfnt">&nbsp;At&nbsp;</font> <font class="bluefnt">
                            <%=brcd%>
                        </font>
                    </td>
                    <td style="text-align: left; width: 15%">
                        <font class="blackfnt">ETD:</font>
                    </td>
                    <td style="text-align: left">
                        <font class="bluefnt">
                            <%= ETDDate + " " + ETDTime%>
                        </font><font class="blackfnt">&nbsp;To&nbsp;</font> <font class="bluefnt">
                            <%=DepartingTo%>
                        </font>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td style="text-align: left; width: 15%">
                        <font class="blackfnt">Out VFS (%):</font>
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtVFS" runat="server" MaxLength="3" Width="30" />
                    </td>
                    <td style="text-align: left; width: 15%">
                        <font class="blackfnt">Seal #:</font>
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtSeal" runat="server" MaxLength="10" Width="60" />
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td style="text-align: left; width: 15%">
                        <font class="blackfnt">ATD:</font>
                    </td>
                    <td colspan="3" style="text-align: left">
                        <asp:TextBox ID="txtATD" runat="server" CssClass="input" MaxLength="10" Width="70"></asp:TextBox>
                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtATD,'b','dd/MM/yyyy'); return false;"
                            id="b">
                            <img src="./../../images/calendar.jpg" border="0" />
                        </a>
                        <asp:TextBox ID="txtHHMM" runat="server" MaxLength="5" Width="30" CssClass="input"></asp:TextBox>
                        <font class="blackfnt">dd/mm/yyyy HH:MM</font>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td style="text-align: left; width: 15%">
                        <font class="blackfnt">Emp.Code:</font>
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtEmpCode" runat="server" Width="50"></asp:TextBox> 
                    </td>
                    <td style="text-align: left; width: 15%">
                        <font class="blackfnt">Outgoing Remarks:</font>
                    </td>
                    <td style="text-align: left">
                        <textarea id="txtOutgoingRemarks" runat="server" rows="2" cols="40">Okay</textarea>
                    </td>
                </tr>
            </table>
            <br />
            

            <table cellpadding="3" cellspacing="1" border="0" class="boxbg" id="tblMFList" runat="server"
                width="1000" visible="true">
                <tr style="background-color: White">
                    <td align="center">
                        <font class="blackfnt"><b>MFs available for THC Departure</b></font>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <asp:GridView ID="dgMFs" EnableViewState="true" runat="server" CellSpacing="1" CellPadding="3"
                            HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." Width="100%" DataSourceID="MySQLDataSource_MFAvailable"
                            DataKeyNames="TCNO,TOT_DKT,Pkgs,Wts">
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <input type="CheckBox" name="SelectAllCheckBox" onclick="SelectAll(this)">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkMF" EnableViewState="true" Text="" />
                                        <input type="hidden" name="tcdt" value='<%# DataBinder.Eval(Container.DataItem, "MF_Date")%>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="TCNO" HeaderText="Sys. MF #" ReadOnly="True" />
                                <asp:BoundField DataField="manual_tcno" HeaderText="Manual MF #" ReadOnly="True" />
                                <asp:BoundField DataField="TCBR" HeaderText="MF Br." ReadOnly="True" />
                                <asp:BoundField DataField="MF_Date" HeaderText="MF Date" ReadOnly="True" />
                                <asp:BoundField DataField="ToBH_CODE" HeaderText="Next Stop" ReadOnly="True" />
                                <asp:BoundField DataField="TOT_DKT" HeaderText="Total Dkts." ReadOnly="True" />
                                <asp:BoundField DataField="Pkgs" HeaderText="Pkgs L/B" ReadOnly="True" />
                                <asp:BoundField DataField="Wts" HeaderText="Wt. L/B" ReadOnly="True" />
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <asp:Button ID="btnDepartTHC" runat="server" ValidationGroup="grpShowMF" Text="Depart THC >>"
                            OnClientClick="return ValidateData2()" OnClick="DepartTHC" />
                    </td>
                </tr>
            </table>
            
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 100;">
    </div>
</asp:Content>
