<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="UpdateDRS.aspx.cs" Inherits="GUI_Operations_DRS_UpdateDRS" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
        <asp:SqlDataSource ID="MySQLDataSource_DelyReasons" runat="server" ProviderName="System.Data.SqlClient"
        SelectCommand="usp_DeliveryReasons" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

    <script src="../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    <script src="./Js/DRS.js" language="javascript" type="text/javascript"></script>

    <script src="../../Js/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script src="../../Js/AssignValue.js" language="javascript" type="text/javascript"></script>

    <asp:UpdatePanel ID="upDRSUpdate"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <table cellspacing="1" style="width: 900px">
                <tr style="background-color: white">
                    <td align="left" style="width: 50%">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Update DRS:</asp:Label>
                        <hr align="center" size="1" color="#8ba0e5">
                        <asp:HiddenField ID="hDRS" runat="server" EnableViewState="true" />
                        <asp:HiddenField ID="hDktsInDRS" runat="server" EnableViewState="true" />
                        <asp:HiddenField ID="hXMLData" runat="server" EnableViewState="true"/>
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
            <br />
            <table cellspacing="1" cellpadding="3" style="width: 700px" class="boxbg">
                <tr class="bgbluegrey">
                    <td align="left" colspan="2">
                        <font class="blackfnt"><b>DRS Header Information:</b></font>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">DRS #:</font>
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                            <%= drsCode%>
                        </font><font class="blackfnt">&nbsp;Delivered By&nbsp;</font> <font class="bluefnt">
                            <%= deliveredBy%>
                        </font><font class="blackfnt">-</font> <font class="bluefnt">
                            <%= ba_staff%>
                        </font>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">DRS Date:</font>
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                            <%= drsDate %>
                        </font>
                        <input type="hidden" name="hDRSDate" value="<%= drsDate %>" />
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Driver Name:</font>
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                            <%=driverName %>
                        </font><font class="blackfnt">&nbsp;of Vehicle&nbsp;</font> <font class="bluefnt">
                            <%=vehicleno %>
                        </font><font class="blackfnt">&nbsp;Carrying&nbsp;</font> <font class="bluefnt">
                            <%=totalDkts %>
                        </font><font class="blackfnt">&nbsp;Consignment(s)&nbsp;</font>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Start/Close KM:</font>
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                            <%=startKM %></font>
                            <input type="hidden" name="hStartKM" value="<%= startKM %>" />
                        <font class="blackfnt">&nbsp;/&nbsp;</font>
                        <asp:TextBox ID="txtCloseKM" runat="server" Width="30"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <table cellspacing="1" cellpadding="3" style="width: 1200px" class="boxbg">
                <tr class="bgbluegrey">
                    <td align="left">
                        <font class="blackfnt"><b>Sr.#</b></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><b>Docket<br />
                            Bkg. Dt.</b></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><b>Bkg-Dely<br />
                            Dest.Loc<br />
                            Pay Basis</b></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><b>Cnor/Cnee</b></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><b>Pkgs<br />
                            Pending/Arrived/Booked</b></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><b>Committed<br/>Dely. Dt</b></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"><b>Pkgs.<br/>Delivered</b></font>
                    </td>
                </tr>
                <asp:Repeater ID="rptDocketList" runat="server" Visible="true">
                    <ItemTemplate>
                        <tr style="background-color: White">
                            <td align="left">
                                <font class="blackfnt">
                                    <%# Container.ItemIndex + 1%>
                                </font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "dockno").ToString().Trim() + DataBinder.Eval(Container.DataItem, "docksf").ToString().Trim() + "<br/>" + DataBinder.Eval(Container.DataItem, "Booking_Date").ToString().Trim()%>
                                </font>
                                <asp:HiddenField ID="hDocket" runat="Server" Value='<%# DataBinder.Eval(Container.DataItem, "dockno").ToString().Trim()%>' />
                                <asp:HiddenField ID="hDocketSF" runat="Server" Value='<%# DataBinder.Eval(Container.DataItem, "docksf").ToString().Trim()%>' />
                                <asp:HiddenField ID="hPkgsPending" runat="Server" Value='<%# DataBinder.Eval(Container.DataItem, "Pkgs_Pending").ToString().Trim()%>' />
                                <asp:HiddenField ID="hCODDOD" runat="Server" Value='<%# DataBinder.Eval(Container.DataItem, "COD_DOD").ToString().Trim()%>' />
                                <asp:HiddenField ID="hCommDelyDt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "Comm_Dely_Dt").ToString().Trim()%>' />
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "orgncd").ToString().Trim() + "-" + DataBinder.Eval(Container.DataItem, "destcd").ToString().Trim() + "<br/>" + DataBinder.Eval(Container.DataItem, "DelyLocation").ToString().Trim() + "<br/>" + DataBinder.Eval(Container.DataItem, "PayBasis").ToString().Trim()%>
                                </font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "csgncd").ToString().Trim() + ":" + DataBinder.Eval(Container.DataItem, "csgnnm").ToString().Trim() + "<br/>" + DataBinder.Eval(Container.DataItem, "csgecd").ToString().Trim() + ":" + DataBinder.Eval(Container.DataItem, "csgenm").ToString().Trim()%>
                                </font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <%# "<font color='red'>" + DataBinder.Eval(Container.DataItem, "Pkgs_Pending").ToString().Trim() + "</font> / "  + DataBinder.Eval(Container.DataItem, "Pkgs_Arrived").ToString().Trim() + " / " + DataBinder.Eval(Container.DataItem, "Pkgs_Booked").ToString().Trim()%>
                                </font>
                            </td>
                            <td align="left">
                                <font class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Comm_Dely_Dt").ToString().Trim()%>
                                </font>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtPkgsDelivered" runat="server" Width="30" CssClass="input"></asp:TextBox>
                            </td>
                        </tr>
                        <tr style="background-color: White">
                            <td colspan="7">
                                <table cellspacing="1" cellpadding="3" border="0" class="boxbg" width="100%">
                                    <tr style="background-color: #EFEFEF">
                                        <td align="left">
                                            <font class="blackfnt">Delivery Date &amp; Time:</font>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtDelyDt" runat="server" MaxLength="10" Width="70" CssClass="input" Text='<%# DateTime.Now.ToString("dd/MM/yyyy") %>'></asp:TextBox>
                                            <a href="#" onclick="var a=<%#Container.ItemIndex %>;if(a>9){a = 'ctl00_MyCPH1_rptDocketList_ctl' + a +'_txtDelyDt'} else {a = 'ctl00_MyCPH1_rptDocketList_ctl' + '0'+a+'_txtDelyDt' };var lnk=a+'lnk'/*; alert(lnk)*/;this.id=lnk;cal.select(eval('document.aspnetForm.'+a),this.id,'dd/MM/yyyy'); return false;">
                                                <img src="./../../images/calendar.jpg" border="0" />
                                            </a>&nbsp;
                                            <asp:TextBox ID="txtHHMM" runat="server" MaxLength="5" Width="30" CssClass="input" Text='<%# DateTime.Now.ToString("HH:mm") %>'></asp:TextBox>
                                            <font class="blackfnt">dd/mm/yyyy HH:MM</font>
                                        </td>
                                        <td align="left">
                                            <font class="blackfnt">Reason:</font>
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="cboReason" runat="server" CssClass="input" DataSourceID="MySQLDataSource_DelyReasons"
                            DataTextField="Code" DataValueField="CodeID">
                                            </asp:DropDownList>
                                        </td>
                                        <td align="left">
                                            <font class="blackfnt">Person:</font>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtPerson" runat="server" CssClass="input" Width="100" MaxLength="50"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        
                        <tr style="background-color: White" runat="server" visible='<%# DataBinder.Eval(Container.DataItem, "CODDOD")%>'>
                            <td colspan="7">
                                <table cellspacing="1" cellpadding="3" border="0" class="boxbg" width="100%">
                                    <tr style="background-color: #FFFFDF">
                                        <td align="left" style="width:15%">
                                            <font class="blackfnt">COD/DOD Amount:</font>
                                        </td>
                                        <td align="left" style="width:20%">
                                            <font class="blackfnt"><%# DataBinder.Eval(Container.DataItem, "CODDODAmount")%></font>
                                            <asp:HiddenField ID="hCODDODAmount" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "CODDODAmount")%>'/>
                                        </td>
                                        <td align="left" style="width:15%">
                                            <font class="blackfnt">COD/DOD Collected:</font>
                                        </td>
                                        <td align="left" style="width:20%">
                                            <asp:TextBox ID="txtCODDOCCollected" runat="server" Width="30" CssClass="input"></asp:TextBox>
                                        </td>
                                        <td align="left" style="width:10%">
                                            <font class="blackfnt">COD/DOD #:</font>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtCODDODNo" runat="server" Width="100" CssClass="input" MaxLength="25"></asp:TextBox>
                                        </td>
                                        
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                
                <tr style="background-color: White" runat="server">
                    <td colspan="7" align="left">
                        <asp:Button Text="Update DRS >>" ID="btnUpdateDRS" runat="server" OnClientClick="return ValidateDocketData()" OnClick="UpdateDRS"/>
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
