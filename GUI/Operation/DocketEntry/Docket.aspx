<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Docket.aspx.cs" Inherits="GUI_Operation_DocketEntry_Docket" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="pgb" %>
<%@ Register Src="~/GUI/Common_UserControls/ucServiceTax.ascx" TagPrefix="UserControl" TagName="ucServiceTax" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="MyCPH1">

    <script type="text/javascript" language="javascript" src="../../images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/dragndrop.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript" src="DocketScripts.js?V2"></script>

    <script language="JavaScript" type="text/javascript" src="DocketEntry.js?V1"></script>
    <script src="../../Common_UserControls/Js/ServiceTax.js?V1"></script>
    <font class="blackfnt"><b><u>Note</u> :-</b>
        <br />
        &nbsp;&nbsp; - <font class="redfnt"><b>*</b></font> Fields are Mandatory
        <br />
        &nbsp;&nbsp; -&nbsp; Please Enter Date in [dd/mm/yyyy] Format </font>
    <asp:UpdatePanel ID="updstep1n2" runat="server">
        <ContentTemplate>
            <asp:Panel ID="divmpsources" runat="server" Style="margin: 1px 1px 1px 1px; display: block; position: absolute; border: solid #8ba0e5 1px; left: 450px; top: 250px; width: 350px;"
                BackColor="white" Width="250px">
                <asp:Table ID="tblmpsources" runat="server" Style="margin: 2px 2px 2px 2px;" CellSpacing="1"
                    CssClass="boxbg" Width="98.9%">
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell HorizontalAlign="Center" Font-Bold="true">
                            <asp:Label Width="98%" ID="lblmpheader" onmouseover="this.style.cursor='move'" onmousedown="javascript:return dragStart(event,'ctl00_MyCPH1_divmpsources')"
                                runat="server" CssClass="blackfnt" Font-Bold="true"> MultiPickPoint Sources</asp:Label>
                        </asp:TableCell>
                        <asp:TableCell HorizontalAlign="Center">
                            <asp:Label ID="lblclosesource" runat="server" Font-Bold="true" CssClass="blackfnt"
                                onmouseover="this.style.cursor='pointer'" onclick="javascript:return document.getElementById('ctl00_MyCPH1_divmpsources').style.display='none';return false;"
                                Text="X"></asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgwhite">
                        <asp:TableCell ColumnSpan="2">
                            <asp:Panel runat="server" Style="height: 120px; scrollbar-base-color: #d4e0e7; scrollbar-3dlight-color: #d4e0e7; scrollbar-highlight-color: #d4e0e7; scrollbar-shadow-color: #d4e0e7;"
                                ID="divinnermps"
                                ScrollBars="Vertical">
                                <asp:Table CssClass="boxbg" CellSpacing="1" CellPadding="1" runat="server" ID="tblsources"
                                    Width="90%">
                                </asp:Table>
                            </asp:Panel>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
            <asp:Table runat="server" ID="tbladf">
                <asp:TableRow>
                    <asp:TableCell>
                        <div id="divstep1" runat="server" style="width: 10in;">
                            <asp:Table ID="tblstep1" HorizontalAlign="left" runat="server" CellSpacing="1" Style="width: 100%"
                                CssClass="boxbg">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell HorizontalAlign="center" ColumnSpan="6">
                            <b><%=dkt_call%> Entry</b></asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trentrytype" runat="server" CssClass="bgwhite">
                                    <asp:TableCell>Entry Type</asp:TableCell>
                                    <asp:TableCell ColumnSpan="5">
                                        <asp:RadioButtonList ID="optentrytype" onclick="javascript:return parcelClick()"
                                            RepeatDirection="Horizontal" runat="server" CssClass="blackfnt">
                                            <asp:ListItem Value="N" Selected="True" Text="Normal"></asp:ListItem>
                                            <asp:ListItem Value="C" Text="Computerized"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite" ID="trdockno" runat="server">
                                    <asp:TableCell HorizontalAlign="left" Style="width: 150px;">
                            <font class="redfnt"><b>*</b></font><%=dkt_call%>
                            Nubmer</asp:TableCell>
                                    <asp:TableCell Style="width: 200px;">
                                        <asp:Table runat="server">
                                            <asp:TableRow>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtdockno" runat="server" onblur="javascript:return dockNoTest(this.getAttribute('id'))"
                                                        Width="70px" MaxLength="20" CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox>
                                                    <asp:Label ID="lbldockno" runat="server" CssClass="redfnt">&lt;System Generated&gt;</asp:Label>
                                                    <asp:HyperLink ID="hylone" runat="server" onclick="javascript:return openDockHelp()"
                                                        Font-Bold="true"></asp:HyperLink>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Image ID="imgdockettick" ImageUrl="~/GUI/images/dockettick.jpg" Width="15px"
                                                        Style="display: none;" Height="15px" runat="server" />
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableCell>
                                    <asp:TableCell Style="width: 100px;">
                            <font class="redfnt"><b>*</b></font><%=dkt_call%>
                            Date</asp:TableCell>
                                    <asp:TableCell Style="width: 220px;">
                                        <asp:TextBox ID="txtdockdate" runat="server" Width="70px" MaxLength="10" CssClass="blackfnt"
                                            BorderStyle="Groove" onblur="javascript:return alertInvalidDate('dockdate')">
                                        </asp:TextBox>
                                        <asp:Label ID="lbldockdateimage" runat="server">
                            <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtdockdate,'ancdockdate','dd/MM/yyyy'); return false;"
                                name="ancdockdate" id="ancdockdate">
                                <img src="../../images/calendar.jpg" alt="calendar.jpg"
                                    border="0" />
                            </a>
                                        </asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell Style="width: 90px;">
                            <font class="redfnt"><b>*</b></font>Payment Type</asp:TableCell>
                                    <asp:TableCell Style="width: 150px;">
                                        <asp:DropDownList ID="cmbpaybas" BackColor="white" DataTextField="codedesc" DataValueField="codeid"
                                            runat="server" onchange="javascript:return payBaseChange()" CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite" ID="trdockparty" runat="server">
                                    <asp:TableCell>
                            <font class="redfnt"><b>*</b></font>Billing Party</asp:TableCell>
                                    <asp:TableCell Style="width: 200px;" VerticalAlign="top">
                                        <asp:Table runat="server">
                                            <asp:TableRow>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtpartycode" Width="80px" onblur="javascript:return partyTest('party',this.getAttribute('id'))"
                                                        MaxLength="10" runat="server" BorderStyle="groove" CssClass="blackfnt"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <input type="button" id="btnpartypopup" onclick="javascript: return popupParty()"
                                                        value="..." class="blackfnt" runat="server" />
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Image ID="imgviewparty" runat="server" onclick="javascript:return viewParty()"
                                                        onmouseover="this.style.cursor='pointer'" ImageUrl="~/GUI/images/question.GIF" />
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtpartyname" runat="server" Width="100px" Enabled="false" BorderWidth="0"></asp:TextBox><br />
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow>
                                                <asp:TableCell ColumnSpan="3">
                                                    <asp:Label ID="lblcontracterror" runat="server" CssClass="redfnt" Font-Bold="true"
                                                        Visible="false" Text="No Contract found for this Party."></asp:Label>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            Origin Location</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblorgnloc" Font-Bold="true" runat="server" CssClass="bluefnt"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell Width="100px">
                            <font class="redfnt"><b>*</b></font>To City<br></br>Delivery Location</asp:TableCell>
                                    <asp:TableCell CssClass="blackfnt">
                                        <div runat="server" id="myPanel" class="blackfnt">
                                            <asp:TextBox ID="txtto" runat="server" onkeypress="javascript:return withoutQuote(event)"
                                                MaxLength="35" BorderStyle="Groove" Width="80px" CssClass="blackfnt"></asp:TextBox>
                                            <input type="button" id="btntopopup" onclick="javascript: return popupToCity()" value="..."
                                                class="blackfnt" runat="server" />
                                        </div>
                                        <asp:TextBox ID="txtdelloc" runat="server" BorderStyle="groove" Width="40px" MaxLength="8" Enabled="true"
                                            onblur="javascript:return locTest(this.getAttribute('id'),'delloc');" CssClass="blackfnt"></asp:TextBox>
                                        <input type="button" id="btndelpopup" value="..." onclick="javascript: return popupDelLoc()" style="display: none"
                                            class="blackfnt" runat="server" />
                                        <%--<atlas:AutoCompleteExtender DropDownPanelID="myPanel" ID="acedelloc" runat="server">
                                            <atlas:AutoCompleteProperties Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetDeliveryLocation"
                                                ServicePath="../../services/WebService.asmx" TargetControlID="txtdelloc" />
                                        </atlas:AutoCompleteExtender>--%>
                                        <ajaxToolkit:AutoCompleteExtender ID="acedelloc" runat="server" Enabled="True" MinimumPrefixLength="1"
                                            ServiceMethod="GetDeliveryLocation" CompletionListItemCssClass="autocomplete_listItem"
                                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../../services/WebService.asmx"
                                            TargetControlID="txtdelloc">
                                        </ajaxToolkit:AutoCompleteExtender>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite" ID="trbtnstep1">
                                    <asp:TableCell VerticalAlign="Top" HorizontalAlign="Right" ColumnSpan="3">
                                        <asp:Panel ID="divpartycsgne" runat="server" HorizontalAlign="Left">
                                            <asp:Table runat="server">
                                                <asp:TableRow>
                                                    <asp:TableCell>
                                                        <asp:RadioButton ID="optpartycsgn" Checked="true" GroupName="partycsgne" runat="server"
                                                            CssClass="blackfnt" Text="Consignor As Billing Party" />
                                                    </asp:TableCell>
                                                    <asp:TableCell>
                                                        <asp:RadioButton ID="optpartycsge" GroupName="partycsgne" runat="server" CssClass="blackfnt"
                                                            Text="Consignee As Billing Party" />
                                                    </asp:TableCell>
                                                </asp:TableRow>
                                            </asp:Table>
                                        </asp:Panel>
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="Left">Service Tax Exempted
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:CheckBox ID="chkservicetaxexemp" runat="server" CssClass="blackfnt" />
                                    </asp:TableCell>
                                    <asp:TableCell VerticalAlign="Top" HorizontalAlign="Right">
                                        <asp:Button ID="btnstep1" Text="Step 1" OnClick="btnstep1_Click" OnClientClick="javascript:return validateStep1()"
                                            runat="server" CssClass="blackfnt" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trtransmode" Width="100%" CssClass="bgwhite">
                                    <asp:TableCell Style="width: 150px;">
                            <font class="redfnt"><b>*</b></font>Mode</asp:TableCell>
                                    <asp:TableCell Style="width: 200px;">
                                        <asp:DropDownList ID="cmbtransmode" BackColor="white" runat="server" CssClass="blackfnt" onfocus="return showOtherProduct()">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                    <asp:TableCell Style="width: 100px;">
                            <font class="redfnt"><b>*</b></font>Service Type</asp:TableCell>
                                    <asp:TableCell Style="width: 220px;">
                                        <asp:DropDownList ID="cmbservicetype" BackColor="white" onchange="javascript:return serviceChange()"
                                            runat="server" CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                    <asp:TableCell Style="width: 90px;">
                            <font class="redfnt"><b>*</b></font>Type of FTL</asp:TableCell>
                                    <asp:TableCell Style="width: 150px;">
                                        <asp:DropDownList ID="cmbftltype" DataTextField="codedesc" DataValueField="codeid"
                                            BackColor="white" Enabled="false" runat="server" CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trpickupdel" CssClass="bgwhite">
                                    <asp:TableCell>
                            <font class="redfnt"><b>*</b></font>PickUp/Delivery</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="cmbpickupdel" BackColor="white" CssClass="blackfnt" runat="server">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblfromcityname" runat="server" CssClass="blackfnt">From </asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtfrom" runat="server" onkeypress="javascript:return withoutQuote(event)"
                                            MaxLength="35" BorderStyle="Groove" Width="80px" CssClass="blackfnt"></asp:TextBox>
                                        <input type="button" id="btnfrompopup" value="..." onclick="javascript: return popupFromCity()"
                                            class="blackfnt" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trpacktype" CssClass="bgwhite">
                                    <asp:TableCell>
                            <font class="redfnt"><b>*</b></font>Packaging Type</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="cmbpacktype" DataTextField="codedesc" DataValueField="codeid"
                                            runat="server" BackColor="white" CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            <font class="redfnt"><b>*</b></font>Said to Contain</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="cmbprodtype" DataTextField="codedesc" DataValueField="codeid" onchange="return showOtherProduct()"
                                            runat="server" Width="200px" BackColor="white" CssClass="blackfnt">
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtProdType" runat="server" CssClass="ltxtm" Width="120px" MaxLength="50" Style="display: none" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                            Special Instructions</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtsplinstruct" onkeypress="javascript:return withoutQuote(event)"
                                            TextMode="MultiLine" runat="server" CssClass="blackfnt"></asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trvolumetric" CssClass="bgwhite" Style="display: none">
                                    <asp:TableCell>
                            Volumertic</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:CheckBox ID="chkvolumetric" onclick="javascript:return volumetricClick()" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                            COD/DOD</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:CheckBox ID="chkcoddod" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                            ODA</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:CheckBox ID="chkoda" Enabled="false" runat="server" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trlocal" CssClass="bgwhite">
                                    <asp:TableCell>
                            Local
                            <%=dkt_call %>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:CheckBox ID="chklocal" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblloadtypename" Style="display: none;" runat="server" CssClass="blackfnt"><font class="redfnt"><b>*</b></font>Load Type</asp:Label>
                                        <asp:Label ID="lbldopinoname" Style="display: none;" runat="server" CssClass="blackfnt">DOPI NO</asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell ColumnSpan="3">
                                        <asp:DropDownList ID="cmbloadtype" DataTextField="codedesc" DataValueField="codeid"
                                            Style="display: none;" runat="server" BackColor="white" CssClass="blackfnt">
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtdopino" runat="server" Style="display: none;" CssClass="blackfnt"
                                            Width="70px" MaxLength="20" BorderStyle="Groove"></asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trdacc" CssClass="bgwhite" Style="display: none">
                                    <asp:TableCell>
                            DACC
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:CheckBox ID="chkdacc" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                                    Permit Applicable</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:CheckBox ID="chkpermit" onclick="javascript:return permitCheck()" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell ColumnSpan="2"></asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trmultipoint" CssClass="bgwhite">
                                    <asp:TableCell HorizontalAlign="left">Multi-Point PickUp</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:CheckBox ID="chkmultipickup" onclick="javascript:return multiPickUpClick()"
                                            runat="server" CssClass="blackfnt" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblsourcedockname" runat="server" CssClass="blackfnt"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Table runat="server">
                                            <asp:TableRow>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtsourcedockno" onblur="javascript:return sourceDockNoTest(this.getAttribute('id'))"
                                                        runat="server" Width="100px" MaxLength="10" CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Image ID="imgsourcedock" runat="server" onclick="javascript:return openSources()"
                                                        onmouseover="this.style.cursor='pointer'" ImageUrl="~/GUI/images/question.GIF" />
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="left">Multi-Point Delivery</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:CheckBox ID="chkmultidelivery" onclick="javascript:return multiPickUpClick()"
                                            runat="server" CssClass="blackfnt" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trbtnstep2" CssClass="bgwhite">
                                    <asp:TableCell>
                            <font class="redfnt"><b>*</b></font>Business Type
                                    </asp:TableCell>
                                    <asp:TableCell ColumnSpan="4">
                                        <asp:DropDownList ID="cmbbusinesstype" DataTextField="codedesc" DataValueField="codeid"
                                            runat="server" BackColor="white" CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                    <asp:TableCell HorizontalAlign="right" ColumnSpan="4">
                                        <asp:Button ID="btnstep2" Text="Step 2" OnClick="btnstep2_Click" OnClientClick="javascript:return validateStep2()"
                                            runat="server" CssClass="blackfnt" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                    </asp:TableCell>
                </asp:TableRow>
                <%--STEP  2 ENDS HERE--%>
                <%-- ---------------------------------------------------------------------------------------------------
                            STEP 2 ENDS HERE
------------------------------------------------------------------------------------------------------%>
                <asp:TableRow>
                    <asp:TableCell>
                        <div id="divstep3" runat="server" style="margin: 2px 0px 0px 0px; width: 10in; display: none;">
                            <asp:Table Style="width: 100%" runat="server">
                                <asp:TableRow>
                                    <asp:TableCell>
                                        <asp:Table ID="tblconsignee" HorizontalAlign="left" runat="server" Style="width: 100%"
                                            CellSpacing="1" CssClass="boxbg">
                                            <asp:TableRow CssClass="bgbluegrey">
                                                <asp:TableCell>
                                                </asp:TableCell>
                                                <asp:TableCell HorizontalAlign="center" Font-Bold="true">
                                        Consignor</asp:TableCell>
                                                <asp:TableCell HorizontalAlign="center" Font-Bold="true">
                                        Consignee</asp:TableCell>
                                                <asp:TableCell ColumnSpan="2" HorizontalAlign="center" Font-Bold="true">
                                        Document</asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="bgwhite">
                                                <asp:TableCell>
                                        Code</asp:TableCell>
                                                <asp:TableCell>
                                                    <font class="redfnt"><b>*</b></font>Enter From Existing Consignor<br />
                                                    <asp:TextBox ID="txtcsgncd" runat="server" TabIndex="1" MaxLength="10" onblur="javascript:return partyTest('csgn',this.getAttribute('id'))"
                                                        Width="60px" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>-
                                                    <asp:TextBox ID="txtcsgnnm" runat="server" Enabled="false" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                    <input type="button" id="btncsgnpopup" value="..." tabindex="2" onclick="javascript: return popupConsignor()"
                                                        class="blackfnt" runat="server" />
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <font class="redfnt"><b>*</b></font>Enter From Existing Consignee<br />
                                                    <asp:TextBox ID="txtcsgecd" runat="server" TabIndex="5" MaxLength="10" onblur="javascript:return partyTest('csge',this.getAttribute('id'))"
                                                        Width="60px" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>-
                                                    <asp:TextBox ID="txtcsgenm" runat="server" Enabled="false" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                    <input type="button" id="btncsgepopup" value="..." tabindex="6" onclick="javascript: return popupConsignee()"
                                                        class="blackfnt" runat="server" />
                                                </asp:TableCell>
                                                <asp:TableCell>
                                        Risk Type</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Table runat="server">
                                                        <asp:TableRow>
                                                            <asp:TableCell>
                                                                <asp:RadioButton ID="optcarrierrisk" TabIndex="9" Checked="true" runat="server" Text="Carrier's Risk"
                                                                    GroupName="risktype" />
                                                            </asp:TableCell>
                                                            <asp:TableCell>
                                                                <asp:RadioButton ID="optownerrisk" TabIndex="9" runat="server" Text="Owner's Risk"
                                                                    GroupName="risktype" />
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="bgwhite">
                                                <asp:TableCell ColumnSpan="3" HorizontalAlign="center">
                                        <b>New</b></asp:TableCell>
                                                <asp:TableCell>
                                        Policy No. and Date</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtpolicyno" runat="server" MaxLength="50" Width="80px" BorderStyle="Groove"
                                                        TabIndex="10" onkeypress="javascript:return withoutQuote(event)" CssClass="blackfnt"></asp:TextBox>
                                                    <asp:TextBox ID="txtpolicydate" runat="server" onblur="javascript:return alertInvalidDate('policy')"
                                                        TabIndex="11" MaxLength="10" Width="70px" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtpolicydate,'ancpolicydate','dd/MM/yyyy'); return false;"
                                                        name="ancpolicydate" id="ancpolicydate">
                                                        <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0" />
                                                    </a>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="bgwhite">
                                                <asp:TableCell>
                                        <font class="redfnt"><b>*</b></font>Name</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtcsgnname" runat="server" MaxLength="30" Width="140px" TabIndex="3"
                                                        onkeypress="javascript:return withoutQuote(event)" BorderStyle="Groove" CssClass="blackfnt"
                                                        onblur="this.value=this.value.toUpperCase();"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtcsgename" runat="server" MaxLength="30" Width="140px" TabIndex="7"
                                                        onkeypress="javascript:return withoutQuote(event)" BorderStyle="Groove" CssClass="blackfnt"
                                                        onblur="this.value=this.value.toUpperCase();"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                        Customer Ref.</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtcustrefno" TabIndex="12" runat="server" MaxLength="20" Width="80px" onblur="setCustomerRefNo()"
                                                        onkeypress="javascript:return withoutQuote(event)" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                    <script>
                                                        function setCustomerRefNo() {
                                                            try {
                                                                var txtcustrefno = document.getElementById(ControlIdPrefix + 'txtcustrefno');
                                                                var txtprivatemark = document.getElementById(ControlIdPrefix + 'txtprivatemark');
                                                                var txtinvoiceno = document.getElementById(ControlIdPrefix + "grvinvoice_ctl02_txtinvoiceno");
                                                                txtprivatemark.value = txtcustrefno.value;
                                                                txtinvoiceno.value = txtcustrefno.value;
                                                            } catch (e) { }
                                                        }

                                                    </script>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="bgwhite" ID="trAddress" runat="server">
                                                <asp:TableCell>
                                        <font class="redfnt"><b>*</b></font>Address</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtcsgnaddress" TextMode="MultiLine" CssClass="blackfnt" TabIndex="1"
                                                        onkeypress="javascript:return withoutQuote(event)" BorderStyle="Groove" Width="170px"
                                                        runat="server" onblur="this.value=this.value.toUpperCase();"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtcsgeaddress" TextMode="MultiLine" CssClass="blackfnt" TabIndex="2"
                                                        onkeypress="javascript:return withoutQuote(event)" BorderStyle="Groove" Width="170px"
                                                        runat="server" onblur="this.value=this.value.toUpperCase();"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                        Modvat Covers</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtmodvatcovers" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                        MaxLength="10" Width="80px" TabIndex="3" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="bgwhite" ID="trCity" runat="server">
                                                <asp:TableCell>
                                        <font class="redfnt"><b>*</b></font>City-Pincode</asp:TableCell>
                                                <asp:TableCell VerticalAlign="top">
                                                    <asp:Table runat="server">
                                                        <asp:TableRow>
                                                            <asp:TableCell HorizontalAlign="left">
                                                                <asp:TextBox ID="txtcsgncity" CssClass="blackfnt" TabIndex="1" BorderStyle="Groove"
                                                                    onkeypress="javascript:return withoutQuote(event)" onblur="this.value=this.value.toUpperCase()"
                                                                    MaxLength="20" Width="100px" runat="server"></asp:TextBox>
                                                                <input type="button" id="btncsgncitypopup" onclick="javascript: return popupCSGNCity()"
                                                                    value="..." class="blackfnt" runat="server" />-
                                                            </asp:TableCell>
                                                            <asp:TableCell>
                                                                <asp:TextBox ID="txtcsgnpin" runat="server" CssClass="blackfnt" Width="70px" BorderStyle="groove"
                                                                    MaxLength="6" onkeypress="javascript:return validInt(event)" TabIndex="1" Style="text-align: right;"></asp:TextBox>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </asp:TableCell>
                                                <asp:TableCell VerticalAlign="top">
                                                    <asp:Table runat="server">
                                                        <asp:TableRow>
                                                            <asp:TableCell HorizontalAlign="left">
                                                                <asp:TextBox ID="txtcsgecity" CssClass="blackfnt" TabIndex="2" BorderStyle="Groove"
                                                                    onkeypress="javascript:return withoutQuote(event)" onblur="this.value=this.value.toUpperCase()"
                                                                    MaxLength="20" Width="100px" runat="server"></asp:TextBox>
                                                                <input type="button" id="btncsgecitypopup" onclick="javascript: return popupCSGECity()"
                                                                    value="..." class="blackfnt" runat="server" />-
                                                            </asp:TableCell>
                                                            <asp:TableCell HorizontalAlign="left">
                                                                <asp:TextBox ID="txtcsgepin" runat="server" CssClass="blackfnt" Width="70px" MaxLength="6"
                                                                    onkeypress="javascript:return validInt(event)" BorderStyle="groove" TabIndex="2"
                                                                    Style="text-align: right;"></asp:TextBox>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                    Internal Covers</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtinternalcovers" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                        MaxLength="10" Width="80px" TabIndex="3" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="bgwhite">
                                                <asp:TableCell>
                                        <font class="redfnt"><b>*</b></font>Telephone</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtcsgnphone" CssClass="blackfnt" BorderStyle="Groove" MaxLength="20"
                                                        Style="text-align: right;" TabIndex="4" onkeypress="javascript:return validInt(event)"
                                                        Width="100px" runat="server"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtcsgephone" CssClass="blackfnt" BorderStyle="Groove" MaxLength="20"
                                                        Style="text-align: right;" TabIndex="8" onkeypress="javascript:return validInt(event)"
                                                        Width="100px" runat="server"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                        Private Mark</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtprivatemark" runat="server" TabIndex="13" MaxLength="20" Width="80px"
                                                        onkeypress="javascript:return withoutQuote(event)" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="bgwhite" ID="trEmail" runat="server">
                                                <asp:TableCell>
                                        E-mail</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtcsgnemail" CssClass="blackfnt" BorderStyle="Groove" MaxLength="40"
                                                        TabIndex="1" Width="100px" runat="server" onblur="javascript:return emailCheck(this.getAttribute('id'))"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtcsgeemail" CssClass="blackfnt" BorderStyle="Groove" MaxLength="40"
                                                        TabIndex="2" Width="100px" runat="server" onblur="javascript:return emailCheck(this.getAttribute('id'))"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                        TP Number</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txttpnumber" runat="server" TabIndex="3" MaxLength="20" Width="80px"
                                                        onkeypress="javascript:return withoutQuote(event)" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow ID="trentrysheetno" runat="server" Style="display: none;" CssClass="bgwhite">
                                                <asp:TableCell>
                                        Entry Sheet No</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtentrysheetno" CssClass="blackfnt" BorderStyle="Groove" MaxLength="20"
                                                        TabIndex="1" Width="100px" onkeypress="javascript:return withoutQuote(event)"
                                                        runat="server"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                        OBD No.
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtobdno" runat="server" MaxLength="20" Width="80px" BorderStyle="Groove"
                                                        TabIndex="2" onkeypress="javascript:return withoutQuote(event)" CssClass="blackfnt"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                        <%-- CONSIGNOR - CONSIGNEE PANEL--%>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell>
                                        <br />
                                        <asp:Table ID="tbldocdetails" HorizontalAlign="left" runat="server" CellSpacing="1"
                                            Style="width: 100%" CssClass="boxbg">
                                            <asp:TableRow CssClass="bgbluegrey">
                                                <asp:TableCell HorizontalAlign="center" Font-Bold="true">
                                        Document Details</asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="bgwhite">
                                                <asp:TableCell>
                                                    <asp:GridView HorizontalAlign="center" ID="grvdoc" runat="server" BorderWidth="0"
                                                        CellSpacing="1" AllowSorting="true" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                                        HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="bgbluegrey" AutoGenerateColumns="false"
                                                        EmptyDataText="No Records Found..." Style="width: 100%;">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Document Name" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                                <ItemStyle BackColor="white" />
                                                                <ItemTemplate>
                                                                    <center>
                                                                        <asp:Label CssClass="blackfnt" ID="STFORM" Text='<%# DataBinder.Eval(Container.DataItem,"STFORM") %>'
                                                                            runat="server"></asp:Label>
                                                                    </center>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Required" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                                <ItemStyle BackColor="white" />
                                                                <ItemTemplate>
                                                                    <center>
                                                                        <asp:Label CssClass="blackfnt" ID="STCSTREQ" Text='<%# DataBinder.Eval(Container.DataItem,"STCSTREQ") %>'
                                                                            runat="server"></asp:Label>
                                                                    </center>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Applicable in State" HeaderStyle-CssClass="blackfnt"
                                                                HeaderStyle-HorizontalAlign="Center">
                                                                <ItemStyle BackColor="white" />
                                                                <ItemTemplate>
                                                                    <center>
                                                                        <asp:Label CssClass="blackfnt" ID="STNM" Text='<%# DataBinder.Eval(Container.DataItem,"STNM") %>'
                                                                            runat="server"></asp:Label>
                                                                    </center>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                                <HeaderTemplate>
                                                                    <asp:Label ID="Declared_Value1" CssClass="blackfnt" Text="Enclosed Document Number"
                                                                        runat="server"></asp:Label>
                                                                </HeaderTemplate>
                                                                <ItemStyle BackColor="white" />
                                                                <ItemTemplate>
                                                                    <center>
                                                                        <font class="redfnt"><b>*</b></font>
                                                                        <asp:TextBox ID="txtdocumentno" runat="server" Style="text-transform: uppercase"
                                                                            MaxLength="20" BorderStyle="groove" Columns="12" TabIndex="3" CssClass="blackfnt"
                                                                            onchange="javascript:this.value=this.value.toUpperCase()" Text="" onkeypress="javascript:return withoutQuote(event)"></asp:TextBox>
                                                                        <asp:HiddenField ID="Doc_srno" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"Doc_srno") %>' />
                                                                    </center>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                        <%--DOCUMENT DETAILS TABLE--%>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow>
                                    <asp:TableCell>
                                        <br />
                                        <asp:Table runat="server" Style="width: 10in;">
                                            <asp:TableRow>
                                                <asp:TableCell>
                                                    <asp:Table ID="tblpermit" HorizontalAlign="left" runat="server" Style="width: 100%; display: none;"
                                                        CellSpacing="1" CssClass="boxbg">
                                                        <asp:TableRow CssClass="bgbluegrey">
                                                            <asp:TableCell HorizontalAlign="center" ColumnSpan="6" Font-Bold="true">
                                                    Permit Tracker</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow BackColor="white">
                                                            <asp:TableCell>
                                                    Permit Recieved At</asp:TableCell>
                                                            <asp:TableCell>
                                                                <asp:DropDownList ID="cmbpermitrecvdat" CssClass="blackfnt" BackColor="white" TabIndex="3"
                                                                    runat="server">
                                                                    <asp:ListItem Value="0">Select</asp:ListItem>
                                                                    <asp:ListItem Value="B">Booking</asp:ListItem>
                                                                    <asp:ListItem Value="D">Delivery</asp:ListItem>
                                                                    <asp:ListItem Value="C">Check Post</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </asp:TableCell>
                                                            <asp:TableCell>
                                                    Permit Number</asp:TableCell>
                                                            <asp:TableCell>
                                                                <asp:TextBox ID="txtpermitno" runat="server" MaxLength="8" TabIndex="3" Width="80px"
                                                                    BorderStyle="Groove" onkeypress="javascript:return withoutQuote(event)" onblur="this.value=this.value.toUpperCase()"
                                                                    CssClass="blackfnt"></asp:TextBox>
                                                            </asp:TableCell>
                                                            <asp:TableCell>
                                                            </asp:TableCell>
                                                            <asp:TableCell>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow BackColor="white">
                                                            <asp:TableCell>
                                                    Permit Date</asp:TableCell>
                                                            <asp:TableCell>
                                                                <asp:TextBox ID="txtpermitdate" runat="server" MaxLength="10" Width="70px" onblur="javascript:return alertInvalidDate('permit')"
                                                                    TabIndex="3" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                                <asp:Label ID="lblpermitdate" runat="server">
                                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtpermitdate,'ancpermitdate','dd/MM/yyyy'); return false;"
                                                        name="ancpermitdate" id="ancpermitdate">
                                                        <img src="../../images/calendar.jpg" alt="calendar.jpg"
                                                            border="0" />
                                                    </a></asp:Label>
                                                            </asp:TableCell>
                                                            <asp:TableCell>
                                                    Permit Validity Date</asp:TableCell>
                                                            <asp:TableCell>
                                                                <asp:TextBox ID="txtpermitvaldate" runat="server" MaxLength="10" Width="70px" onblur="javascript:return alertInvalidDate('permitvalidity')"
                                                                    TabIndex="3" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                                <asp:Label ID="lblpermitvaliditydate" runat="server">
                                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtpermitvaldate,'ancpermitvaldate','dd/MM/yyyy'); return false;"
                                                        name="ancpermitvaldate" id="ancpermitvaldate">
                                                        <img src="../../images/calendar.jpg" alt="calendar.jpg"
                                                            border="0" /></a>
                                                                </asp:Label>
                                                            </asp:TableCell>
                                                            <asp:TableCell>
                                                    Permit Recieved Date</asp:TableCell>
                                                            <asp:TableCell>
                                                                <asp:TextBox ID="txtpermitrecvddate" runat="server" MaxLength="10" Width="70px" onblur="javascript:return alertInvalidDate('permitrecvd')"
                                                                    TabIndex="3" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                                <asp:Label ID="lblpermitrecieveddate" runat="server">
                                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtpermitrecvddate,'ancpermitrecvddate','dd/MM/yyyy'); return false;"
                                                        name="ancpermitrecvddate" id="ancpermitrecvddate">
                                                        <img src="../../images/calendar.jpg" alt="calendar.jpg"
                                                            border="0" />
                                                    </a>
                                                                </asp:Label>
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow>
                                                <asp:TableCell>
                                                    <asp:Table ID="tblstep3" HorizontalAlign="left" runat="server" Style="width: 100%;"
                                                        CellSpacing="1" CssClass="boxbg">
                                                        <asp:TableRow ID="trbtnstep3" Style="display: none;" runat="server" CssClass="bgwhite">
                                                            <asp:TableCell HorizontalAlign="right" ColumnSpan="6">
                                                                <asp:Button ID="btnstep3" Text="Step 3" TabIndex="3" OnClientClick="javascript:return validateStep3()"
                                                                    runat="server" CssClass="blackfnt" />
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <%--step3 ENDS HERE--%>
                        <br />
                        <br />
                        <div id="divstep4" style="width: 10in; display: none;" runat="server">
                            <asp:Table ID="tblinvoice" HorizontalAlign="left" runat="server" Style="width: 100%"
                                CellSpacing="1" CssClass="boxbg">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell ColumnSpan="2" HorizontalAlign="center" Font-Bold="true">
                            Invoice Details</asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite" ID="trcubicfeet" Style="display: none;" runat="server">
                                    <asp:TableCell ColumnSpan="2" HorizontalAlign="center">
                                        <asp:Table ID="tblcubicfeet" HorizontalAlign="center" runat="server" Style="width: 70%"
                                            CellSpacing="1" CssClass="boxbg">
                                            <asp:TableRow CssClass="bgwhite" HorizontalAlign="left">
                                                <asp:TableCell>
                                        <font class="redfnt">*</font>CFT Conversion Ratio
                                                </asp:TableCell>
                                                <asp:TableCell CssClass="bluefnt">
                                                    <asp:Label ID="lblcubicname" runat="server" CssClass="blackfnt"></asp:Label>
                                                    <asp:TextBox ID="txtcubicrate" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                                        onblur="javascript:return invoiceCalculation()" onkeypress="javascript:return validInt(event)"
                                                        TabIndex="4" MaxLength="2" Style="text-align: right;" Width="50px"></asp:TextBox>
                                                    Kg
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <font class="redfnt">*</font>
                                                    Total CFT Weight
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txttotcubic" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                                        onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" MaxLength="6"
                                                        Enabled="false" Style="text-align: right;" Width="80px"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell Style="width: 50%;" HorizontalAlign="right">
                            No of Rows
                                    </asp:TableCell>
                                    <asp:TableCell Style="width: 50%;">
                                        <asp:TextBox ID="txtinvoicerows" onkeypress="javascript:return validInt(event)" Style="text-align: right; vertical-align: middle"
                                            runat="server" MaxLength="2" Width="40px" BorderStyle="Groove"
                                            TabIndex="14" CssClass="blackfnt"></asp:TextBox>
                                        <asp:Button ID="btnaddrows" runat="server" Text="Generate Rows" OnClientClick="javascript:return generateRows()"
                                            TabIndex="15" OnClick="btnaddrows_click" CssClass="blackfnt" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell ColumnSpan="2">
                                        <asp:GridView HorizontalAlign="center" ID="grvinvoice" runat="server" BorderWidth="0"
                                            CellSpacing="1" AllowSorting="true" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                            HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="bgbluegrey" AutoGenerateColumns="false"
                                            ShowFooter="true" OnRowDataBound="grvinvoice_RowDataBound" EmptyDataText="No Records Found..."
                                            Style="width: 100%;">
                                            <Columns>
                                                <asp:TemplateField HeaderText="SRNO" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemStyle BackColor="White" />
                                                    <ItemTemplate>
                                                        <center>
                                                            <asp:Label CssClass="blackfnt" ID="lblsrno" Text='<%# DataBinder.Eval(Container.DataItem,"SRNO") %>'
                                                                runat="server">
                                                            </asp:Label>
                                                        </center>
                                                    </ItemTemplate>
                                                    <FooterStyle BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                                    <FooterTemplate>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                    <HeaderTemplate>
                                                        <font class="redfnt">*</font>
                                                        <asp:Label ID="lblinvoiceno" CssClass="blackfnt" Text="Invoice No." runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemStyle BackColor="White" />
                                                    <ItemTemplate>
                                                        <center>
                                                            <asp:TextBox ID="txtinvoiceno" onblur="javascript:validateInvoiceNo(this.getAttribute('id'));"
                                                                onkeypress="javascript:return withoutQuote(event)" runat="server" MaxLength="15"
                                                                TabIndex="15" CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                                        </center>
                                                    </ItemTemplate>
                                                    <FooterStyle BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                                    <FooterTemplate>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                    <HeaderTemplate>
                                                        <font class="redfnt">*</font>
                                                        <asp:Label ID="lblinvoicedate" CssClass="blackfnt" Text="Invoice Date" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemStyle BackColor="White" />
                                                    <ItemTemplate>
                                                        <center>
                                                            <asp:TextBox ID="txtinvoicedate" runat="server" MaxLength="10" CssClass="blackfnt"
                                                                Text='<%# DataBinder.Eval(Container.DataItem,"invdt") %>' onblur="javascript:return validateInvoiceDate(this.getAttribute('id'))"
                                                                TabIndex="15" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                                            <asp:LinkButton ID="lnkinvoicedate" runat="server">
                                                       <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0"></a>
                                                            </asp:LinkButton>
                                                        </center>
                                                    </ItemTemplate>
                                                    <FooterStyle BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                                    <FooterTemplate>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                    <HeaderTemplate>
                                                        <font class="redfnt">*</font>
                                                        <asp:Label ID="lbllength" CssClass="blackfnt" Text="Length" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemStyle BackColor="White" />
                                                    <ItemTemplate>
                                                        <center>
                                                            <asp:TextBox ID="txtlength" CssClass="blackfnt" Style="text-align: right;" onkeypress="javascript:return validInt(event)"
                                                                onblur="javascript:return invoiceCalculation()" Width="70px" MaxLength="5" runat="server"
                                                                TabIndex="15" Text="0" BorderStyle="Groove"></asp:TextBox>
                                                        </center>
                                                    </ItemTemplate>
                                                    <FooterStyle BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                                    <FooterTemplate>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                    <HeaderTemplate>
                                                        <font class="redfnt">*</font>
                                                        <asp:Label ID="lblbreadth" CssClass="blackfnt" Text="Breadth" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemStyle BackColor="White" />
                                                    <ItemTemplate>
                                                        <center>
                                                            <asp:TextBox ID="txtbreadth" runat="server" CssClass="blackfnt" Style="text-align: right;"
                                                                onkeypress="javascript:return validInt(event)" onblur="javascript:return invoiceCalculation()"
                                                                TabIndex="15" MaxLength="5" Text="0" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                                        </center>
                                                    </ItemTemplate>
                                                    <FooterStyle BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                                    <FooterTemplate>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                    <HeaderTemplate>
                                                        <font class="redfnt">*</font>
                                                        <asp:Label ID="lblheight" CssClass="blackfnt" Text="Height" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemStyle BackColor="White" />
                                                    <ItemTemplate>
                                                        <center>
                                                            <asp:TextBox ID="txtheight" runat="server" CssClass="blackfnt" Style="text-align: right;"
                                                                onkeypress="javascript:return validInt(event)" onblur="javascript:return invoiceCalculation()"
                                                                TabIndex="15" MaxLength="5" Text="0" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                                        </center>
                                                    </ItemTemplate>
                                                    <FooterStyle BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                                    <FooterTemplate>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                    <HeaderTemplate>
                                                        <font class="redfnt">*</font>
                                                        <asp:Label ID="lbldeclval" CssClass="blackfnt" Text="Declared Value" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemStyle BackColor="White" />
                                                    <ItemTemplate>
                                                        <center>
                                                            <asp:TextBox ID="txtdeclval" runat="server" CssClass="blackfnt" Style="text-align: right;"
                                                                onkeypress="javascript:return validInt(event);" onblur="javascript:return invoiceCalculation()"
                                                                TabIndex="15" MaxLength="9" Text="0" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                                        </center>
                                                    </ItemTemplate>
                                                    <FooterStyle BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                                    <FooterTemplate>
                                                        <asp:TextBox ID="txttotdeclval" runat="server" CssClass="blackfnt" Style="text-align: right;"
                                                            Enabled="false" Text="0" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                    <HeaderTemplate>
                                                        <font class="redfnt">* </font>
                                                        <asp:Label ID="lblnopkgs" CssClass="blackfnt" Text="No. of Pkgs." runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemStyle BackColor="White" />
                                                    <ItemTemplate>
                                                        <center>
                                                            <asp:TextBox ID="txtnopkgs" runat="server" CssClass="blackfnt" Style="text-align: right;"
                                                                onkeypress="javascript:return validInt(event);" onblur="javascript:return invoiceCalculation()"
                                                                TabIndex="15" MaxLength="5" Text="0" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                                        </center>
                                                    </ItemTemplate>
                                                    <FooterStyle BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                                    <FooterTemplate>
                                                        <asp:TextBox ID="txttotnopkgs" runat="server" CssClass="blackfnt" Style="text-align: right;"
                                                            Enabled="false" Text="0" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center">
                                                    <HeaderTemplate>
                                                        <asp:Label ID="lbltotalweight" CssClass="blackfnt" Text="Cubic Weight" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemStyle BackColor="White" />
                                                    <ItemTemplate>
                                                        <center>
                                                            <asp:TextBox ID="txtcft" runat="server" CssClass="blackfnt" Style="text-align: right;"
                                                                onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" onblur="javascript:return invoiceCalculation()"
                                                                MaxLength="8" Enabled="false" Text="0" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                                        </center>
                                                    </ItemTemplate>
                                                    <FooterStyle BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                                    <FooterTemplate>
                                                        <asp:TextBox ID="txttotalcft" runat="server" CssClass="blackfnt" Style="text-align: right;"
                                                            Enabled="false" Text="0" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderStyle-HorizontalAlign="Center" AccessibleHeaderText="actwt_test"
                                                    Visible="true">
                                                    <HeaderTemplate>
                                                        <font class="redfnt">*</font>
                                                        <asp:Label ID="lblactualweight" CssClass="blackfnt" Text="Actual Weight" runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <ItemStyle BackColor="White" />
                                                    <ItemTemplate>
                                                        <center>
                                                            <asp:TextBox ID="txtactualweight" runat="server" CssClass="blackfnt" Style="text-align: right;"
                                                                onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" onblur="javascript:return invoiceCalculation()"
                                                                TabIndex="15" MaxLength="9" Text="0" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                                        </center>
                                                    </ItemTemplate>
                                                    <FooterStyle HorizontalAlign="Center" BackColor="white" CssClass="blackfnt" />
                                                    <FooterTemplate>
                                                        <asp:TextBox ID="txttotactualweight" runat="server" CssClass="blackfnt" Style="text-align: right;"
                                                            Enabled="false" Text="0" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                                    </FooterTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell HorizontalAlign="right" ColumnSpan="2">
                                        Total Charged Weight&nbsp;
                                        <asp:TextBox ID="txttotchargedweight" runat="server" CssClass="blackfnt" Style="text-align: right;"
                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" onblur="javascript:return chargedWeightTest()"
                                            TabIndex="15" MaxLength="8" Text="0" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <br />
                        <div id="divpayment" runat="server" style="width: 10in; display: none;">
                            <asp:Table HorizontalAlign="left" runat="server" CellSpacing="1" Style="width: 100%"
                                CssClass="boxbg">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell HorizontalAlign="center">
                                        <asp:Button ID="btnpayment" runat="server" TabIndex="15" OnClick="btnpayment_Click"
                                            CssClass="blackfnt" OnClientClick="javascript:return paymentClick()" Text="Click Here For Payment Details" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <br />
                        <div id="divcharges" runat="server" style="width: 10in; display: none;">
                            <asp:Label ID="lblminfreightalert" runat="server" CssClass="redfnt" Font-Bold="true"></asp:Label><br />
                            <br />
                            <asp:Table HorizontalAlign="left" runat="server" CellSpacing="1" Style="width: 100%"
                                CssClass="boxbg">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell HorizontalAlign="center" ColumnSpan="6" Font-Bold="true">
                            Payment Details</asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell>
                            Freight Charges</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:HiddenField ID="hdnfreightcharge" runat="server" />
                                        <asp:TextBox ID="txtfreightcharge" runat="server" CssClass="blackfnt" BorderStyle="Groove"
											onfocus="javascript:return calculateSubTotal();"
                                            onblur="javascript:return freightChargeBlur()" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            Style="text-align: right;" MaxLength="10" Width="80px"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="cmbratetype" runat="server" DataTextField="codedesc" DataValueField="codeid"
											onfocus="javascript:return calculateSubTotal();"
                                            onchange="javascript:return freightRateBlur()" BackColor="White" CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:HiddenField ID="hdnfreightrate" runat="server" />
                                        <asp:TextBox ID="txtfreightrate" runat="server" CssClass="blackfnt" BorderStyle="Groove"
											onfocus="javascript:return calculateSubTotal();"
                                            onblur="javascript:return freightRateBlur()" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            Style="text-align: right;" MaxLength="10" Width="80px"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            EDD</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtedd" runat="server" Width="70px" MaxLength="10" CssClass="blackfnt"
                                            BorderStyle="Groove" onblur="javascript:return alertInvalidDate('edd')"></asp:TextBox>
                                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtedd,'ancedd','dd/MM/yyyy'); return false;"
                                            name="ancedd" id="ancedd">
                                            <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0" />
                                        </a>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trDiscount" runat="server" CssClass="bgwhite">
                                    <asp:TableCell>
                                        <asp:Label ID="lblDiscount" runat="server" CssClass="blackfnt" Text="Discount Amount" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtDiscount" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Width="80px" Style="text-align: right;" MaxLength="5" ReadOnly="true" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        Discount Type :-
                                        <asp:Label ID="lblDiscountType" runat="server" CssClass="blackfnt" />
                                    </asp:TableCell>
                                    <asp:TableCell ColumnSpan="3" />
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell>
                            Service Tax Paid By</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="cmbstaxpaidby" runat="server" BackColor="White" onchange="javascript:return calculateSubTotal();"
                                            CssClass="blackfnt">
                                            <asp:ListItem Text="Consignor" Value="CO"></asp:ListItem>
                                            <asp:ListItem Text="Consignee" Value="CE"></asp:ListItem>
                                            <asp:ListItem Text="Billing Party" Value="P"></asp:ListItem>
                                            <asp:ListItem Text="Transporter" Value="T"></asp:ListItem>
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblFOVRate" CssClass="blackfnt" Text="FOV Rate(%)" runat="server"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtfovrate" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            onblur="javascript:return calculateFOV()" MaxLength="10" Width="80px" Style="text-align: right;"
                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblFOVCharged" CssClass="blackfnt" Text="FOV Charged" runat="server"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtfovcharged" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            MaxLength="10" Width="50px" Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            onblur="javascript:return chargeBlur(this.getAttribute('id'))"></asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trfov" runat="server" CssClass="bgwhite">
                                    <asp:TableCell>
                                        <asp:Label ID="lblFOVCalculated" CssClass="blackfnt" Text="FOV Calculated" runat="server"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtfovcalculated" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Enabled="false" MaxLength="10" Width="80px" Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            Service Tax Reg. No</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtstaxregno" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            onkeypress="javascript:return withoutQuote(event)" MaxLength="10" Width="80px"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblbilledat" runat="server" CssClass="blackfnt">Billed At</asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtbilledat" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            onblur="javascript:return locTest(this.getAttribute('id'),'billloc');" MaxLength="5"
                                            Width="50px" Enabled="false"></asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>

                                <asp:TableRow ID="trcoddod" runat="server" CssClass="bgwhite">
                                    <asp:TableCell>
                            COD/DOD Charged
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtcoddodcharged" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            MaxLength="10" Width="80px" onblur="javascript:return chargeBlur(this.getAttribute('id'));"
                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            COD/DOD To be Collected
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtcoddodcollected" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            MaxLength="10" Width="80px" Text="0.00" Style="text-align: right;" onblur="javascript:this.value=roundNumber(this.value,2);"
                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trdacccharge" runat="server" CssClass="bgwhite">
                                    <asp:TableCell>
                            DACC Charged
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtdacccharged" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            MaxLength="10" Width="80px" onblur="javascript:return chargeBlur(this.getAttribute('id'));"
                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            DACC To be Collected
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtdacccollected" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            MaxLength="10" Width="80px" Text="0.00" onblur="javascript:this.value=roundNumber(this.value,2);"
                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell ColumnSpan="6" HorizontalAlign="left">
                                        <asp:GridView HorizontalAlign="left" ID="grvcharges" runat="server" BorderWidth="0"
                                            CellSpacing="1" AllowSorting="true" PagerStyle-HorizontalAlign="left" ShowHeader="false"
                                            CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="<%=boxbg%>"
                                            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                                            PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." OnRowDataBound="grvcharges_RowDataBound"
                                            Style="width: 70%;">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Required" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemStyle BackColor="white" HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:Label CssClass="blackfnt" ID="txtchargename1" Text='<%# DataBinder.Eval(Container.DataItem,"chargename1") %>'
                                                            runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Applicable in State" HeaderStyle-CssClass="blackfnt"
                                                    HeaderStyle-HorizontalAlign="Center">
                                                    <ItemStyle BackColor="white" HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtcharge1" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                                            MaxLength="10" Width="80px" Style="text-align: right;" Text='<%# DataBinder.Eval(Container.DataItem,"chargevalue1") %>'
                                                            onblur="javascript:return gridChargeBlur(this.getAttribute('id'));" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                                        <asp:Label ID="lbloperator1" runat="server" CssClass="bluefnt" Font-Bold="true"></asp:Label>
                                                        <asp:HiddenField ID="hdnchargecode1" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"chargecode1") %>' />
                                                        <asp:HiddenField ID="hdnactiveflag1" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"activeflag1") %>' />
                                                        <asp:HiddenField ID="hdnchargevalue1" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"chargevalue1") %>' />
                                                        <asp:HiddenField ID="hdnoperator1" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"operator1") %>' />
                                                        <asp:HiddenField ID="hdnenabled1" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"enabled1") %>' />
                                                        <asp:HiddenField ID="hdnvarybyloc1" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"varybyloc1") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Required" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:Label CssClass="blackfnt" ID="txtchargename2" Text='<%# DataBinder.Eval(Container.DataItem,"chargename2") %>'
                                                            runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Applicable in State" HeaderStyle-CssClass="blackfnt"
                                                    HeaderStyle-HorizontalAlign="Center">
                                                    <ItemStyle CssClass="bluefnt" BackColor="white" HorizontalAlign="Left" />
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtcharge2" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                                            MaxLength="10" Width="80px" Style="text-align: right;" Text='<%# DataBinder.Eval(Container.DataItem,"chargevalue2") %>'
                                                            onblur="javascript:return gridChargeBlur(this.getAttribute('id'));" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                                        <asp:Label ID="lbloperator2" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                                        <asp:HiddenField ID="hdnchargecode2" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"chargecode2") %>' />
                                                        <asp:HiddenField ID="hdnactiveflag2" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"activeflag2") %>' />
                                                        <asp:HiddenField ID="hdnchargevalue2" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"chargevalue2") %>' />
                                                        <asp:HiddenField ID="hdnoperator2" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"operator2") %>' />
                                                        <asp:HiddenField ID="hdnenabled2" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"enabled2") %>' />
                                                        <asp:HiddenField ID="hdnvarybyloc2" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"varybyloc2") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell ColumnSpan="6">
                                        <UserControl:ucServiceTax runat="server" ID="ucServiceTax" IsRebateApplicable="true" CheckExceedAmount="true"/>
                                    </asp:TableCell>
                                    <%--<asp:TableCell>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            <b>SUB-TOTAL</b></asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtsubtotal" runat="server" CssClass="blackfnt" Text="1150" BorderStyle="Groove"
                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            MaxLength="10" Enabled="false" Width="80px"></asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell>
                            Service Tax Rate(%)</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblservicetaxrate" runat="server" CssClass="bluefnt"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            Service Tax on Sub-Total</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtservicetaxsub" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            Enabled="false" MaxLength="10" Width="80px"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            Service Tax Collected</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtservicetax" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            onblur="javascript:return serviceTaxBlur()" MaxLength="10" Width="80px"></asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell>
                            Educational Cess Rate (%)</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lbleducessrate" runat="server" CssClass="bluefnt"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            Educational Cess on Service Tax</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txteducesssub" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            MaxLength="10" Enabled="false" Width="80px"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            Educational Cess Collected</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txteducess" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            MaxLength="10" onblur="javascript:return serviceTaxBlur()" Width="80px"></asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell>
                            Higher Educational Cess Rate (%)</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblheducessrate" runat="server" CssClass="bluefnt"></asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            Higher Educational Cess on Service Tax</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtheducesssub" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            Enabled="false" onblur="javascript:return calculateServiceTax()" MaxLength="10"
                                            Width="80px"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            Higher Educational Cess Collected</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtheducess" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            onblur="javascript:return serviceTaxBlur()" MaxLength="10" Width="80px"></asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell>
                            SB Cess Rate(%)</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblSbcRate" runat="server" CssClass="bluefnt"></asp:Label>
                                        <asp:HiddenField ID="hdnSbcRate" runat="server"></asp:HiddenField>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            SB Cess on Sub-Total</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtSBCessSub" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            Enabled="false" MaxLength="10" Width="80px"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            SB Cess Collected</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtSBCess" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            Enabled="false" onblur="javascript:return serviceTaxBlur()" MaxLength="10" Width="80px"></asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell></asp:TableCell>
                                    <asp:TableCell></asp:TableCell>
                                    <asp:TableCell></asp:TableCell>
                                    <asp:TableCell></asp:TableCell>
                                    <asp:TableCell>
                            <b>TOTAL</b></asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtdockettotal" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            MaxLength="10" Enabled="false" Width="80px"></asp:TextBox>
                                    </asp:TableCell>--%>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell ColumnSpan="6" HorizontalAlign="center">
                                        <asp:Button ID="btnsubmit" runat="server" OnClientClick="javascript:return submitClick()"
                                            OnClick="btnsubmit_Click" Text="Submit" CssClass="blackfnt" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <%-- ---------------------------------------------------------------------------------------------------
                                HIDDEN BOXES AREA
------------------------------------------------------------------------------------------------------%>
            <%--STORES DISPLAY NAME OF DOCKET AS PER NOMANCLASURE AND SESSION--%>
            <asp:HiddenField ID="hdndockname" runat="server" />
            <%--STORES USER THAT ENTERS DOCKET --%>
            <asp:HiddenField ID="hdnemployee" runat="server" />
            <%--STORES TOTAL DECLARED VALUE--%>
            <asp:HiddenField ID="hdntotdeclval" runat="server" />
            <%--STORES TOTAL NO OF PACKAGES--%>
            <asp:HiddenField ID="hdntotnopkgs" runat="server" />
            <%--STORES TOTAL ACTUAL WEIGHT --%>
            <asp:HiddenField ID="hdntotactualweight" runat="server" />
            <%--STORES RATE FROM CONTRACT MASTER--%>
            <asp:HiddenField ID="hdntbbrate" runat="server" />
            <%--STORES RATE PER KG FROM TRANSITION MASTER--%>
            <%--STORES INFO IF SERVER BUTTON CANBE PRESSED OR NOT 0->OK|||||1->BAD    --%>
            <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
            <%--STORES TODAY DATE FROM DATABASE SERVER--%>
            <asp:HiddenField ID="hdnserverdate" runat="server" />
            <%--STORES TODAY DATE FROM DATABASE SERVER--%>
            <asp:HiddenField ID="hdnserverhour" runat="server" />
            <%--STORES FINACIAL START YEAR SO THAT ACCOUNTING CAN BE EASY CAN BE DONE--%>
            <asp:HiddenField ID="hdnfinstartyear" runat="server" />
            <%--STORES CLIENT ID SO THAT CLIENT SPECIFIC SETTINGS CAN BE DONE--%>
            <asp:HiddenField ID="hdnclient" runat="server" />
            <%--STORES TYPE OF MEASURE CM/INCHES--%>
            <asp:HiddenField ID="hdnvolmeasuretype" runat="server" />
            <%-- STORES MINFREIGHT BASIS --%>
            <asp:HiddenField ID="hdnminfreighttype" runat="server" />
            <%-- STORES MINFREIGHT BASIS --%>
            <asp:HiddenField ID="hdnminfreightbas" runat="server" />
            <%--STORES MINFREIGHT RATE --%>
            <asp:HiddenField ID="hdnminfreightbasrate" runat="server" />
            <%-- STORES MINFREIGHT BASIS --%>
            <asp:HiddenField ID="hdndbfreightrate" runat="server" />
            <asp:HiddenField ID="hdnyieldsubtotalrate" runat="server" />
            <%-- STORES MINFREIGHT BASIS --%>
            <asp:HiddenField ID="hdnminfreightrate" runat="server" />
            <%--STORES MINFREIGHT RATE --%>
            <asp:HiddenField ID="hdnlowlimfreightrate" runat="server" />
            <%--STORES MINFREIGHT RATE --%>
            <asp:HiddenField ID="hdnupplimfreightrate" runat="server" />
            <%-- STORES MINFREIGHT BASIS --%>
            <asp:HiddenField ID="hdnminsubtotal" runat="server" />
            <%--STORES MINFREIGHT RATE --%>
            <asp:HiddenField ID="hdnlowlimsubtotal" runat="server" />
            <%--STORES MINFREIGHT RATE --%>
            <asp:HiddenField ID="hdnupplimsubtotal" runat="server" />
            <%--STORES FOVE TYPE  --%>
            <asp:HiddenField ID="hdnfovtype" runat="server" />
            <%--STORES FOV OWNER RATE --%>
            <asp:HiddenField ID="hdnfovownerrate" runat="server" />
            <%--STORES FOV CARRIER RATE --%>
            <asp:HiddenField ID="hdnfovcarrierrate" runat="server" />
            <%--STORES FOV CHARGE --%>
            <asp:HiddenField ID="hdnfovcharge" runat="server" />
            <%--STORES FOV CHARGE --%>
            <asp:HiddenField ID="hdntrdays" runat="server" />
            <%--STORES FOV CHARGE --%>
            <asp:HiddenField ID="hdnfoundcontract" runat="server" />
            <%--STORES FOV CHARGE --%>
            <asp:HiddenField ID="hdnftlmaxcapacity" runat="server" />
            <%--STORES VALUES N,C,L,R BASED UPON DATA FIND IN CONTRACT --%>
            <asp:HiddenField ID="hdndefaultfov" runat="server" />
            <%--STORES VALUES N,C,L,R BASED UPON DATA FIND IN CONTRACT --%>
            <asp:HiddenField ID="hdnfuelsurchargerate" runat="server" />
            <%--STORES VALUES  IN CONTRACT --%>
            <asp:HiddenField ID="hdnfuelsurchargebas" runat="server" />
            <asp:HiddenField ID="hdnfuelsurmincharge" runat="server" />
            <asp:HiddenField ID="hdnfuelsurmaxcharge" runat="server" />
            <asp:HiddenField ID="hdncontractid" runat="server" />
            <asp:HiddenField ID="hdncontractdepth" runat="server" />
            <asp:HiddenField ID="hdnchargerule" runat="server" />
            <asp:HiddenField ID="hdnchargesubrule" runat="server" />
            <asp:HiddenField ID="hdnbasecode1" runat="server" />
            <asp:HiddenField ID="hdnbasecode2" runat="server" />
            <asp:HiddenField ID="hdnproceed" runat="server" />
            <asp:HiddenField ID="hdncontractsets" runat="server" />
            <asp:HiddenField ID="hdnflagminfreightper" runat="server" />
            <asp:HiddenField ID="hdnflagminsubtotalper" runat="server" />
            <asp:HiddenField ID="hdnflagmultipickup" runat="server" />
            <asp:HiddenField ID="hdnflagloadtype" runat="server" />
            <asp:HiddenField ID="hdnflagprorata" runat="server" />
            <asp:HiddenField ID="hdnflagmstrcsgn" runat="server" />
            <asp:HiddenField ID="hdnflagmstrcsge" runat="server" />
            <asp:HiddenField ID="hdnflagroundoff" runat="server" />
            <asp:HiddenField ID="hdnservicetaxrate" runat="server" />
            <asp:HiddenField ID="hdnRabatePercentage" runat="server" />
            <asp:HiddenField ID="hdnbookdaterule" runat="server" />
            <asp:HiddenField ID="hdnDiscountType" runat="server" />
            <asp:HiddenField ID="hdnDiscountRate" runat="server" />
            <%--                DIV FOR DATE CALENDAR--%>
            <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <pgb:ProgressBar ID="ProgressBar1" runat="server" />

    <script type="text/javascript">
        try {
            payBaseChange();
            cityTest('TO', 'ctl00_MyCPH1_txtto');
            dockNoTest('ctl00_MyCPH1_txtdockno');
        } catch (e) {
            document.getElementById('ctl00_MyCPH1_txtto').value = "";
        }
    </script>
</asp:Content>
