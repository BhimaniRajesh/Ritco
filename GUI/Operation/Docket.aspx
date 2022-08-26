<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Docket.aspx.cs" Inherits="GUI_Operation_DocketEntry_Docket" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="MyCPH1">

    <script type="text/javascript" language="javascript" src="../../images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/dragndrop.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript" src="DocketScripts.js"></script>

    <%----------------------------------- JAVASCRIPT FOR DATE SELECTION CALENDAR -----------------------------%>
    <font class="blackfnt"><b><u>Note</u> :-</b>
        <br />
        &nbsp;&nbsp; - <font class="redfnt"><b>*</b></font> Fields are Mandatory
        <br />
        &nbsp;&nbsp; -&nbsp; Please Enter Date in [dd/mm/yyyy] Format </font>
    <asp:UpdatePanel ID="updstep1n2" runat="server">
        <ContentTemplate>
            <asp:Panel ID="divmpsources" runat="server" Style="margin: 1px 1px 1px 1px; display: block;
                position: absolute; border: solid #8ba0e5 1px; left: 450px; top: 250px; width: 350px;"
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
                    <asp:TableRow BackColor="white">
                        <asp:TableCell ColumnSpan="2">
                            <asp:Panel runat="server" Style="height: 120px; scrollbar-base-color: #d4e0e7; scrollbar-3dlight-color: #d4e0e7;
                                scrollbar-highlight-color: #d4e0e7; scrollbar-shadow-color: #d4e0e7;" ID="divinnermps"
                                ScrollBars="Vertical">
                                <asp:Table CssClass="boxbg" CellSpacing="1" CellPadding="1" runat="server" ID="tblsources"
                                    Width="90%">
                                </asp:Table>


                            </asp:Panel>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
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
            <asp:Table runat="server" ID="tbladf">
                <asp:TableRow>
                    <asp:TableCell>
                        <div id="divstep1" runat="server" style="width: 10in;">
                            <asp:Table ID="tblstep1" HorizontalAlign="left" runat="server" CellSpacing="1" Style="width: 100%"
                                CssClass="boxbg">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell HorizontalAlign="center" ColumnSpan="6">
                            <b>Basic Detailss</b></asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow BackColor="#ffffff" ID="trdockno" runat="server">
                                    <asp:TableCell HorizontalAlign="left" Style="width: 150px;">
                            <font class="redfnt"><b>*</b></font><%=dkt_call%>
                            Nubmer</asp:TableCell>
                                    <asp:TableCell Style="width: 200px;">
                                        <asp:Table runat="server">
                                            <asp:TableRow>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtdockno" runat="server" onblur="javascript:return dockNoTest(this.getAttribute('id'))"
                                                        Width="70px" MaxLength="10" CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox>
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
                                        <asp:DropDownList ID="cmbpaybas" BackColor="white" runat="server" onchange="javascript:return payBaseChange()"
                                            CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow BackColor="#ffffff" ID="trdockparty" runat="server">
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
                                                    <input type="button" id="btnpartypopup" onclick="javascript:return popupParty()"
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
                                    <asp:TableCell>
                            <font class="redfnt"><b>*</b></font>Delivery Location</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtdelloc" runat="server" BorderStyle="groove" Width="40px" MaxLength="5"
                                            onblur="javascript:return locTest(this.getAttribute('id'),'delloc');" CssClass="blackfnt"></asp:TextBox>
                                        <input type="button" id="btndelpopup" value="..." onclick="javascript:return popupDelLoc()"
                                            class="blackfnt" runat="server" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow BackColor="#ffffff" ID="trbtnstep1" runat="server">
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
                                        <asp:Label CssClass="redfnt" ID="lblstaxexmpname" runat="server">(For  Station to Staion & export dockets only)</asp:Label>
                                    </asp:TableCell>
                                    <asp:TableCell VerticalAlign="Top" HorizontalAlign="Right">
                                        <asp:Button ID="btnstep1" Text="Step 1" OnClick="btnstep1_Click" OnClientClick="javascript:return validateStep1()"
                                            runat="server" CssClass="blackfnt" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trtransmode" runat="server" Width="100%" BackColor="#ffffff">
                                    <asp:TableCell Style="width: 150px;">
                            <font class="redfnt"><b>*</b></font>Mode</asp:TableCell>
                                    <asp:TableCell Style="width: 200px;">
                                        <asp:DropDownList ID="cmbtransmode" BackColor="white" runat="server" CssClass="blackfnt">
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
                                        <asp:DropDownList ID="cmbftltype" BackColor="white" Enabled="false" runat="server"
                                            CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trpickupdel" runat="server" BackColor="#ffffff">
                                    <asp:TableCell>
                            <font class="redfnt"><b>*</b></font>PickUp/Delivery</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="cmbpickupdel" BackColor="white" CssClass="blackfnt" runat="server">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblfromcityname" runat="server" CssClass="blackfnt">From </asp:Label></asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtfrom" runat="server" MaxLength="35" BorderStyle="Groove" Width="80px"
                                            CssClass="blackfnt"></asp:TextBox>
                                        <input type="button" id="btnfrompopup" value="..." onclick="javascript:return popupFromCity()"
                                            class="blackfnt" runat="server" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lbltocityname" runat="server" CssClass="blackfnt">To </asp:Label></asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtto" runat="server" MaxLength="35" BorderStyle="Groove" Width="80px"
                                            CssClass="blackfnt"></asp:TextBox>
                                        <input type="button" id="btntopopup" onclick="javascript:return popupToCity()" value="..."
                                            class="blackfnt" runat="server" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trpacktype" runat="server" BackColor="#ffffff">
                                    <asp:TableCell>
                            <font class="redfnt"><b>*</b></font>Packaging Type</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="cmbpacktype" runat="server" BackColor="white" CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            <font class="redfnt"><b>*</b></font>Said to Contain</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="cmbprodtype" runat="server" Width="200px" BackColor="white"
                                            CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            Special Instructions</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtsplinstruct" TextMode="MultiLine" runat="server" CssClass="blackfnt"></asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trvolumetric" runat="server" BackColor="#ffffff">
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
                                <asp:TableRow ID="trlocal" runat="server" BackColor="#ffffff">
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
                                    <asp:TableCell>
                                        <asp:DropDownList ID="cmbloadtype" Style="display: none;" runat="server" BackColor="white"
                                            CssClass="blackfnt">
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtdopino" runat="server" Style="display: none;" CssClass="blackfnt"
                                            Width="70px" MaxLength="20" BorderStyle="Groove"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            <font class="redfnt"><b>*</b></font>Business Type
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="cmbbusinesstype" runat="server" BackColor="white" CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trdacc" runat="server" BackColor="#ffffff">
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
                                <asp:TableRow ID="trmultipoint" runat="server" BackColor="#ffffff">
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
                                                    <asp:TextBox ID="txtsourcedockno" runat="server" Width="100px" MaxLength="10" CssClass="blackfnt"
                                                        BorderStyle="Groove"></asp:TextBox>
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
                                <asp:TableRow ID="trbtnstep2" runat="server" BackColor="#ffffff">
                                    <asp:TableCell HorizontalAlign="right" ColumnSpan="6">
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
                                                <asp:TableCell HorizontalAlign="center">
                                        Consignor</asp:TableCell>
                                                <asp:TableCell HorizontalAlign="center">
                                        Consignee</asp:TableCell>
                                                <asp:TableCell ColumnSpan="2" HorizontalAlign="center">
                                        Document</asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow BackColor="#ffffff">
                                                <asp:TableCell>
                                        Code</asp:TableCell>
                                                <asp:TableCell>
                                                    <font class="redfnt"><b>*</b></font>Enter From Existing Consignor<br />
                                                    <asp:TextBox ID="txtcsgncd" runat="server" TabIndex="1" MaxLength="10" onblur="javascript:return partyTest('csgn',this.getAttribute('id'))"
                                                        Width="60px" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>-
                                                    <asp:TextBox ID="txtcsgnnm" runat="server" Enabled="false" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                    <input type="button" id="btncsgnpopup" value="..." tabindex="2" onclick="javascript:return popupConsignor()"
                                                        class="blackfnt" runat="server" />
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <font class="redfnt"><b>*</b></font>Enter From Existing Consignee<br />
                                                    <asp:TextBox ID="txtcsgecd" runat="server" TabIndex="2" MaxLength="10" onblur="javascript:return partyTest('csge',this.getAttribute('id'))"
                                                        Width="60px" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>-
                                                    <asp:TextBox ID="txtcsgenm" runat="server" Enabled="false" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                    <input type="button" id="btncsgepopup" value="..." tabindex="2" onclick="javascript:return popupConsignee()"
                                                        class="blackfnt" runat="server" />
                                                </asp:TableCell>
                                                <asp:TableCell>
                                        Risk Type</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:Table runat="server">
                                                        <asp:TableRow>
                                                            <asp:TableCell>
                                                                <asp:RadioButton ID="optcarrierrisk" TabIndex="3" Checked="true" runat="server" Text="Carrier's Risk"
                                                                    GroupName="risktype" />
                                                            </asp:TableCell>
                                                            <asp:TableCell>
                                                                <asp:RadioButton ID="optownerrisk" TabIndex="3" runat="server" Text="Owner's Risk"
                                                                    GroupName="risktype" />
                                                            </asp:TableCell>
                                                        </asp:TableRow>
                                                    </asp:Table>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow BackColor="#ffffff">
                                                <asp:TableCell ColumnSpan="3" HorizontalAlign="center">
                                        <b>New</b></asp:TableCell>
                                                <asp:TableCell>
                                        Policy No. and Date</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtpolicyno" runat="server" MaxLength="10" Width="80px" BorderStyle="Groove"
                                                        CssClass="blackfnt"></asp:TextBox>
                                                    <asp:TextBox ID="txtpolicydate" runat="server" onblur="javascript:return alertInvalidDate('policy')"
                                                        MaxLength="10" Width="70px" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtpolicydate,'ancpolicydate','dd/MM/yyyy'); return false;"
                                                        name="ancpolicydate" id="ancpolicydate">
                                                        <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0" />
                                                    </a>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow BackColor="#ffffff">
                                                <asp:TableCell>
                                        <font class="redfnt"><b>*</b></font>Name</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtcsgnname" runat="server" MaxLength="30" Width="140px" TabIndex="1"
                                                        BorderStyle="Groove" CssClass="blackfnt" onblur="this.value=this.value.toUpperCase();"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtcsgename" runat="server" MaxLength="30" Width="140px" TabIndex="2"
                                                        BorderStyle="Groove" CssClass="blackfnt" onblur="this.value=this.value.toUpperCase();"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                        Internal Covers</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtinternalcovers" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                        MaxLength="10" Width="80px" TabIndex="3" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow BackColor="#ffffff">
                                                <asp:TableCell>
                                        <font class="redfnt"><b>*</b></font>Address</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtcsgnaddress" TextMode="MultiLine" CssClass="blackfnt" TabIndex="1"
                                                        BorderStyle="Groove" Width="170px" runat="server" onblur="this.value=this.value.toUpperCase();"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtcsgeaddress" TextMode="MultiLine" CssClass="blackfnt" TabIndex="2"
                                                        BorderStyle="Groove" Width="170px" runat="server" onblur="this.value=this.value.toUpperCase();"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                        Modvat Covers</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtmodvatcovers" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                        MaxLength="10" Width="80px" TabIndex="3" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow BackColor="#ffffff">
                                                <asp:TableCell>
                                        <font class="redfnt"><b>*</b></font>City-Pincode</asp:TableCell>
                                                <asp:TableCell VerticalAlign="top">
                                                    <asp:Table runat="server">
                                                        <asp:TableRow>
                                                            <asp:TableCell HorizontalAlign="left">
                                                                <asp:TextBox ID="txtcsgncity" CssClass="blackfnt" TabIndex="1" BorderStyle="Groove"
                                                                    onblur="this.value=this.value.toUpperCase()" MaxLength="20" Width="100px" runat="server"></asp:TextBox>
                                                                <input type="button" id="btncsgncitypopup" onclick="javascript:return popupCSGNCity()"
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
                                                                    onblur="this.value=this.value.toUpperCase()" MaxLength="20" Width="100px" runat="server"></asp:TextBox>
                                                                <input type="button" id="btncsgecitypopup" onclick="javascript:return popupCSGECity()"
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
                                        Customer Ref.</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtcustrefno" TabIndex="3" runat="server" MaxLength="20" Width="80px"
                                                        BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow BackColor="#ffffff">
                                                <asp:TableCell>
                                        <font class="redfnt"><b>*</b></font>Telephone</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtcsgnphone" CssClass="blackfnt" BorderStyle="Groove" MaxLength="20"
                                                        Style="text-align: right;" TabIndex="1" onkeypress="javascript:return validInt(event)"
                                                        Width="100px" runat="server"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtcsgephone" CssClass="blackfnt" BorderStyle="Groove" MaxLength="20"
                                                        Style="text-align: right;" TabIndex="2" onkeypress="javascript:return validInt(event)"
                                                        Width="100px" runat="server"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                        Private Mark</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtprivatemark" runat="server" TabIndex="3" MaxLength="20" Width="80px"
                                                        BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow BackColor="#ffffff">
                                                <asp:TableCell>
                                        E-mail</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtcsgnemail" CssClass="blackfnt" BorderStyle="Groove" MaxLength="20"
                                                        TabIndex="1" Width="100px" runat="server" onblur="javascript:return emailCheck(this.getAttribute('id'))"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtcsgeemail" CssClass="blackfnt" BorderStyle="Groove" MaxLength="20"
                                                        TabIndex="2" Width="100px" runat="server" onblur="javascript:return emailCheck(this.getAttribute('id'))"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                        TP Number</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txttpnumber" runat="server" TabIndex="3" MaxLength="20" Width="80px"
                                                        BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow ID="trentrysheetno" runat="server" Style="display: none;" BackColor="#ffffff">
                                                <asp:TableCell>
                                        Entry Sheet No</asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtentrysheetno" CssClass="blackfnt" BorderStyle="Groove" MaxLength="20"
                                                        TabIndex="1" Width="100px" onkeypress="javascript:return validAlfaNum(event)"
                                                        runat="server"></asp:TextBox>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                        OBD No.
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:TextBox ID="txtobdno" runat="server" MaxLength="20" Width="80px" BorderStyle="Groove"
                                                        TabIndex="2" onkeypress="javascript:return validAlfaNum(event)" CssClass="blackfnt"></asp:TextBox>
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
                                                <asp:TableCell HorizontalAlign="center">
                                        Document Details</asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow BackColor="#ffffff">
                                                <asp:TableCell>
                                                    <asp:GridView HorizontalAlign="center" ID="grvdoc" runat="server" BorderWidth="0"
                                                        CellSpacing="1" AllowSorting="true" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                                        BackColor="#8ba0e5" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="<%=boxbg%>"
                                                        PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                                                        PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange"
                                                        Style="width: 100%;">
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
                                                                        runat="server"></asp:Label></HeaderTemplate>
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
                                                    <asp:Table ID="tblpermit" HorizontalAlign="left" runat="server" Style="width: 100%;
                                                        display: none;" CellSpacing="1" CssClass="boxbg">
                                                        <asp:TableRow CssClass="bgbluegrey">
                                                            <asp:TableCell HorizontalAlign="center" ColumnSpan="6">
                                                    Permit Tracker</asp:TableCell>
                                                        </asp:TableRow>
                                                        <asp:TableRow BackColor="white">
                                                            <asp:TableCell>
                                                    Permit Recieved At</asp:TableCell>
                                                            <asp:TableCell>
                                                                <asp:DropDownList ID="cmbpermitrecvdat" TabIndex="3" runat="server">
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
                                                                    BorderStyle="Groove" onblur="this.value=this.value.toUpperCase()" CssClass="blackfnt"></asp:TextBox>
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
                                                        <asp:TableRow ID="trbtnstep3" Style="display: none;" runat="server" BackColor="#ffffff">
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
                    </asp:TableCell></asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <%--step3 ENDS HERE--%>
                        <br />
                        <br />
                        <div id="divstep4" style="width: 10in; display: none;" runat="server">
                            <asp:Table ID="tblinvoice" HorizontalAlign="left" runat="server" Style="width: 100%"
                                CellSpacing="1" CssClass="boxbg">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell ColumnSpan="2" HorizontalAlign="center">
                            Invoice Details</asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow BackColor="#ffffff" ID="trcubicfeet" Style="display: none;" runat="server">
                                    <asp:TableCell ColumnSpan="2" HorizontalAlign="center">
                                        <asp:Table ID="tblcubicfeet" HorizontalAlign="center" runat="server" Style="width: 70%"
                                            CellSpacing="1" CssClass="boxbg">
                                            <asp:TableRow BackColor="#ffffff" HorizontalAlign="left">
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
                                <asp:TableRow BackColor="#ffffff">
                                    <asp:TableCell Style="width: 50%;" HorizontalAlign="right">
                            No of Rows
                                    </asp:TableCell>
                                    <asp:TableCell Style="width: 50%;">
                                        <asp:TextBox ID="txtinvoicerows" onkeypress="javascript:return validInt(event)" Style="text-align: right;
                                            vertical-align: middle" runat="server" MaxLength="2" Width="40px" BorderStyle="Groove"
                                            TabIndex="4" CssClass="blackfnt"></asp:TextBox>
                                        <asp:Button ID="btnaddrows" runat="server" Text="Generate Rows" OnClientClick="javascript:return generateRows()"
                                            TabIndex="4" OnClick="btnaddrows_click" CssClass="blackfnt" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow BackColor="#ffffff">
                                    <asp:TableCell ColumnSpan="2">
                                        <asp:GridView HorizontalAlign="center" ID="grvinvoice" runat="server" BorderWidth="0"
                                            CellSpacing="1" AllowSorting="true" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                            BackColor="#8ba0e5" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="<%=boxbg%>"
                                            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                                            PagerSettings-LastPageText="[Last]" ShowFooter="true" OnRowDataBound="grvinvoice_RowDataBound"
                                            EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" Style="width: 100%;">
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
                                                                TabIndex="4" CssClass="blackfnt" Width="70px" BorderStyle="Groove"></asp:TextBox>
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
                                                                TabIndex="4" Width="70px" BorderStyle="Groove"></asp:TextBox>
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
                                                                TabIndex="4" Text="0" BorderStyle="Groove"></asp:TextBox>
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
                                                                TabIndex="4" MaxLength="5" Text="0" Width="70px" BorderStyle="Groove"></asp:TextBox>
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
                                                                TabIndex="4" MaxLength="5" Text="0" Width="70px" BorderStyle="Groove"></asp:TextBox>
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
                                                                TabIndex="4" MaxLength="9" Text="0" Width="70px" BorderStyle="Groove"></asp:TextBox>
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
                                                                TabIndex="4" MaxLength="5" Text="0" Width="70px" BorderStyle="Groove"></asp:TextBox>
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
                                                                TabIndex="4" MaxLength="9" Text="0" Width="70px" BorderStyle="Groove"></asp:TextBox>
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
                                <asp:TableRow BackColor="#ffffff">
                                    <asp:TableCell HorizontalAlign="right" ColumnSpan="2">
                                        Total Charged Weight&nbsp;
                                        <asp:TextBox ID="txttotchargedweight" runat="server" CssClass="blackfnt" Style="text-align: right;"
                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" onblur="javascript:return chargedWeightTest()"
                                            TabIndex="4" MaxLength="8" Text="0" Width="70px" BorderStyle="Groove"></asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </asp:TableCell></asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <br />
                        <div id="divpayment" runat="server" style="width: 10in; display: none;">
                            <asp:Table HorizontalAlign="left" runat="server" CellSpacing="1" Style="width: 100%"
                                CssClass="boxbg">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell HorizontalAlign="center">
                                        <asp:Button ID="btnpayment" runat="server" TabIndex="4" OnClick="btnpayment_Click"
                                            CssClass="blackfnt" OnClientClick="javascript:return paymentClick()" Text="Click Here For Payment Details" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow BackColor="#ffffff">
                                    <asp:TableCell>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </asp:TableCell></asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell>
                        <br />
                        <div id="divcharges" runat="server" style="width: 10in; display: none;">
                            <asp:Label ID="lblminfreightalert" runat="server" CssClass="redfnt" Font-Bold="true"></asp:Label><br />
                            <br />
                            <asp:Table HorizontalAlign="left" runat="server" CellSpacing="1" Style="width: 100%"
                                CssClass="boxbg">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell HorizontalAlign="center" ColumnSpan="6">
                            Payment Details</asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow BackColor="#ffffff">
                                    <asp:TableCell>
                            Freight Charges</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtfreightcharge" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            onblur="javascript:javascript:return freightChargeBlur()" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            Style="text-align: right;" MaxLength="10" Width="80px"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="cmbratetype" runat="server" onchange="javascript:return freightRateBlur()"
                                            BackColor="White" CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtfreightrate" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            onblur="javascript:javascript:return freightRateBlur()" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
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
                                <asp:TableRow BackColor="#ffffff">
                                    <asp:TableCell>
                            Service Tax Paid By</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:DropDownList ID="cmbstaxpaidby" runat="server" BackColor="White" onchange="javascript:return calculateServiceTax();"
                                            CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            Service Tax Reg. No</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtstaxregno" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            MaxLength="10" Width="80px"></asp:TextBox>
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
                                <asp:TableRow ID="trfov" runat="server" BackColor="#ffffff">
                                    <asp:TableCell>
                            FOV Rate(%)
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtfovrate" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            onblur="javascript:return calculateFOV()" MaxLength="10" Width="80px" Style="text-align: right;"
                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            FOV Calculated
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtfovcalculated" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Enabled="false" MaxLength="10" Width="80px" Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            FOV Charged
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtfovcharged" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            MaxLength="10" Width="50px" Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            onblur="javascript:return chargeBlur(this.getAttribute('id'))"></asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow ID="trcoddod" runat="server" BackColor="#ffffff">
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
                                <asp:TableRow ID="trdacccharge" runat="server" BackColor="#ffffff">
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
                                <asp:TableRow BackColor="#ffffff">
                                    <asp:TableCell ColumnSpan="6" HorizontalAlign="left">
                                        <asp:GridView HorizontalAlign="left" ID="grvcharges" runat="server" BorderWidth="0"
                                            CellSpacing="1" AllowSorting="true" PagerStyle-HorizontalAlign="left" ShowHeader="false"
                                            CssClass="boxbg" BackColor="#8ba0e5" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="<%=boxbg%>"
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
                                                        <asp:Label ID="lbloperand1" runat="server" CssClass="bluefnt" Font-Bold="true"></asp:Label>
                                                        <asp:HiddenField ID="hdnchargecode1" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"chargecode1") %>' />
                                                        <asp:HiddenField ID="hdnstatuscode1" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"statuscode1") %>' />
                                                        <asp:HiddenField ID="hdnchargevalue1" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"chargevalue1") %>' />
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
                                                        <asp:Label ID="lbloperand2" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                                        <asp:HiddenField ID="hdnchargecode2" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"chargecode2") %>' />
                                                        <asp:HiddenField ID="hdnstatuscode2" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"statuscode2") %>' />
                                                        <asp:HiddenField ID="hdnchargevalue2" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"chargevalue2") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow BackColor="#ffffff">
                                    <asp:TableCell>
                                    </asp:TableCell>
                                    <asp:TableCell>
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
                                <asp:TableRow BackColor="#ffffff">
                                    <asp:TableCell>
                            Service Tax Rate(%)</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblservicetaxrate" runat="server" Text="12.00" CssClass="bluefnt"></asp:Label>
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
                                <asp:TableRow BackColor="#ffffff">
                                    <asp:TableCell>
                            Educational Cess Rate (%)</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lbleducessrate" runat="server" Text="2.00" CssClass="bluefnt"></asp:Label>
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
                                <asp:TableRow BackColor="#ffffff">
                                    <asp:TableCell>
                            Higher Educational Cess Rate (%)</asp:TableCell>
                                    <asp:TableCell>
                                        <asp:Label ID="lblheducessrate" runat="server" Text="1.00" CssClass="bluefnt"></asp:Label>
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
                                <asp:TableRow BackColor="#ffffff">
                                    <asp:TableCell>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                    </asp:TableCell>
                                    <asp:TableCell>
                                    </asp:TableCell>
                                    <asp:TableCell>
                            <b>TOTAL</b></asp:TableCell>
                                    <asp:TableCell>
                                        <asp:TextBox ID="txtdockettotal" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            MaxLength="10" Enabled="false" Width="80px"></asp:TextBox>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell ColumnSpan="6" HorizontalAlign="center">
                                        <asp:Button ID="btnsubmit" runat="server" OnClientClick="javascript:return submitClick()"
                                            OnClick="btnsubmit_Click" Text="Submit" CssClass="blackfnt" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </asp:TableCell></asp:TableRow>
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
            <%--STORES CONVERTION RATIO NUMBER PER 1 UNIT VOLUME = hdnval * KG--%>
            <asp:HiddenField ID="hdncft2kg" runat="server" />
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
            <%--STORES VALUES N,C,L,R BASED UPON DATA FIND IN CONTRACT for eg. L means location - location data found --%>
            <asp:HiddenField ID="hdnrecordfind" runat="server" />
            <%--STORES VALUES N,C,L,R BASED UPON DATA FIND IN CONTRACT --%>
            <asp:HiddenField ID="hdndefaultfov" runat="server" />
            <%--STORES VALUES N,C,L,R BASED UPON DATA FIND IN CONTRACT --%>
            <asp:HiddenField ID="hdnfuelsurchargerate" runat="server" />
            <%--STORES VALUES  IN CONTRACT --%>
            <asp:HiddenField ID="hdnfuelsurchargebas" runat="server" />
            <asp:HiddenField ID="hdnfuelsurmincharge" runat="server" />
            <asp:HiddenField ID="hdnfuelsurmaxcharge" runat="server" />
            <asp:HiddenField ID="hdncontractid" runat="server" />
            <asp:HiddenField ID="hdncontracttype" runat="server" />
            <asp:HiddenField ID="hdncontractdepth" runat="server" />
            <asp:HiddenField ID="hdncontractsets" runat="server" />
            <asp:HiddenField ID="hdnflagminfreightper" runat="server" />
            <asp:HiddenField ID="hdnflagminsubtotalper" runat="server" />
            <%--                DIV FOR DATE CALENDAR--%>
            <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
                z-index: 99;">
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="divdockhelp" runat="server" Style="margin: 1px 1px 1px 1px; display: none;
                position: absolute; border: solid #8ba0e5 1px; left: 240px; top: 190px;" BackColor="white"
                Width="250px">
                <asp:Table ID="tblcriteria" runat="server" Style="margin: 2px 2px 2px 2px;" CellSpacing="1"
                    CssClass="boxbg" Width="98.5%">
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell HorizontalAlign="Center" Font-Bold="true" ColumnSpan="2">
                            <asp:Table ID="Table1" runat="server" Width="100%">
                                <asp:TableRow>
                                    <asp:TableCell>Select Criteria</asp:TableCell>
                                    <asp:TableCell VerticalAlign="Top" HorizontalAlign="Right">
                                        <asp:Label ID="lbldocknoheaderexit" runat="server" CssClass="blackfnt" onmouseover="this.style.cursor='pointer'"
                                            onclick="document.getElementById('ctl00_MyCPH1_divdockhelp').style.display='none'"
                                            Font-Bold="true" Font-Underline="true" Text="X"></asp:Label>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow BackColor="white">
                        <asp:TableCell>
                            <asp:Label runat="server" CssClass="blackfnt">From Date</asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Label runat="server" CssClass="blackfnt">To Date</asp:Label>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow BackColor="white">
                        <asp:TableCell>
                            <asp:TextBox ID="txtDateFrom" runat="Server" Width="60" BorderStyle="Groove" MaxLength="10"></asp:TextBox>
                            <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDateFrom,'ankdatefrom','dd/MM/yyyy'); return false;"
                                name="ankdatefrom" id="ankdatefrom">
                                <img src="../../images/calendar.jpg" alt="" border="0" />
                            </a>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtDateTo" runat="Server" Width="60" BorderStyle="Groove" MaxLength="10"></asp:TextBox>
                            <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDateTo,'ankdateto','dd/MM/yyyy'); return false;"
                                name="ankdateto" id="ankdateto">
                                <img alt="" src="../../images/calendar.jpg" border="0" />
                            </a>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell ColumnSpan="2" HorizontalAlign="Center">
                            <asp:Button ID="btndockcri" OnClientClick="javascript:return dockNoCriteriaSubmit()"
                                OnClick="btndockcri_Click" runat="server" Text="Submit" CssClass="blackfnt" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <asp:Panel ID="divloading" Style="display: none;" runat="server" Width="100%">
                    <asp:Table ID="Table2" runat="server" Width="100%">
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Image ID="imgdocknoloading" runat="server" ImageUrl="~/GUI/images/waiting.gif" />
                            </asp:TableCell>
                            <asp:TableCell Font-Bold="true">
                        Loading ....
                            </asp:TableCell>
                            <asp:TableCell VerticalAlign="Bottom" HorizontalAlign="Right">
                                <asp:Label ID="lbldocknoexit" runat="server" CssClass="blackfnt" onmouseover="this.style.cursor='pointer'"
                                    onclick="document.getElementById('ctl00_MyCPH1_divdockhelp').style.display='none'"
                                    Font-Underline="true" Text="Exit"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:Panel>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script language="JavaScript" type="text/javascript">
	var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
// ON BLUR OF FREIGHT  CHARGE



function payBaseChange()
{
    var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");
    var txtpartycode=document.getElementById("ctl00_MyCPH1_txtpartycode");
    var btnpartypopup=document.getElementById("ctl00_MyCPH1_btnpartypopup");
    var txtpartyname=document.getElementById("ctl00_MyCPH1_txtpartyname");
    var divpartycsgne=document.getElementById("ctl00_MyCPH1_divpartycsgne");
    
    
    var hdncontractsets=document.getElementById("ctl00_MyCPH1_hdncontractsets");
    var arrsets=hdncontractsets.value.split(',');
    
        switch(cmbpaybas.value)
        {
            case "P01":
                    if(arrsets[0]=="C" || arrsets[0]=="CD")
                    {
                        txtpartycode.disabled=false;
                        txtpartycode.style.backgroundColor="#ffffff";
                        btnpartypopup.style.display="block";
                        txtpartyname.style.display="block";
                        divpartycsgne.style.display="block";
                    }
                    else
                    {
                        txtpartycode.disabled=true;
                        txtpartycode.value="";
                        txtpartycode.style.backgroundColor="#e6e6e6";
                        btnpartypopup.style.display="none";
                        txtpartyname.style.display="none";
                        divpartycsgne.style.display="none";
                        txtpartyname.value="";
                    }
                    break;
            case "P02":
                    if(arrsets[1]=="C" || arrsets[1]=="CD")
                    {
                        txtpartycode.disabled=false;
                        txtpartycode.style.backgroundColor="#ffffff";
                        btnpartypopup.style.display="block";
                        txtpartyname.style.display="block";
                        divpartycsgne.style.display="block";
                    }
                    else
                    {
                        txtpartycode.disabled=true;
                        txtpartycode.value="";
                        txtpartycode.style.backgroundColor="#e6e6e6";
                        btnpartypopup.style.display="none";
                        txtpartyname.style.display="none";
                        divpartycsgne.style.display="none";
                        txtpartyname.value="";
                    }
                    break;
            case "P03":
                    if(arrsets[2]=="C" || arrsets[2]=="CD")
                    {
                        txtpartycode.disabled=false;
                        txtpartycode.style.backgroundColor="#ffffff";
                        btnpartypopup.style.display="block";
                        txtpartyname.style.display="block";
                        divpartycsgne.style.display="block";
                    }
                    else
                    {
                        txtpartycode.disabled=true;
                        txtpartycode.value="";
                        txtpartycode.style.backgroundColor="#e6e6e6";
                        btnpartypopup.style.display="none";
                        txtpartyname.style.display="none";
                        divpartycsgne.style.display="none";
                        txtpartyname.value="";
                    }
                    break;
            default:
                        txtpartycode.disabled=true;
                        txtpartycode.value="";
                        txtpartycode.style.backgroundColor="#e6e6e6";
                        btnpartypopup.style.display="none";
                        txtpartyname.style.display="none";
                        divpartycsgne.style.display="none";
                        txtpartyname.value="";
                    break;
        } // switch of payment basis
  
    return false;
}



function calculateFuelSurCharge()
{
    
    var hdnfuelsurchargebas=document.getElementById("ctl00_MyCPH1_hdnfuelsurchargebas");
    var hdnfuelsurchargerate=document.getElementById("ctl00_MyCPH1_hdnfuelsurchargerate");
    var hdnfuelsurmincharge=document.getElementById("ctl00_MyCPH1_hdnfuelsurmincharge");
    var hdnfuelsurmaxcharge=document.getElementById("ctl00_MyCPH1_hdnfuelsurmaxcharge");
    
    var txtfreightcharge=document.getElementById("ctl00_MyCPH1_txtfreightcharge");
    var txtchargedweight=document.getElementById("ctl00_MyCPH1_txtchargedweight");
    var fuelsurcharge=0.00;
    switch(hdnfuelsurchargebas.value)
    {
        case "%":
                fuelsurcharge=parseFloat(txtfreightcharge.value)*parseFloat(hdnfuelsurchargerate.value)/100;
                
                break;
        case "W":
                fuelsurcharge=parseFloat(txtchargedweight.value)*parseFloat(hdnfuelsurchargerate.value)/100;
                break;
        case "F":
                fuelsurcharge=parseFloat(hdnfuelsurchargerate.value);
                break;
    }
    

    if(fuelsurcharge<parseFloat(hdnfuelsurmincharge.value))
        fuelsurcharge=parseFloat(hdnfuelsurmincharge.value);
        
    if(fuelsurcharge>parseFloat(hdnfuelsurmaxcharge.value))
        fuelsurcharge=parseFloat(hdnfuelsurmaxcharge.value);
        
    
// NOW ADDING SIMPLE CHARGES
    var grvcharges = document.getElementById("ctl00_MyCPH1_grvcharges");
    var rows=grvcharges.rows.length;
    rows=parseFloat(rows)+1;
    var i=0;
    var pref="";
    for(i=2;i<=rows;i++)
    {
        if(i<10)
            pref = "ctl00_MyCPH1_grvcharges_ctl0" + i + "_";
        else
            pref = "ctl00_MyCPH1_grvcharges_ctl" + i + "_";
    
        var txtcharge1 = document.getElementById(pref + "txtcharge1");
        var txtcharge2 = document.getElementById(pref + "txtcharge2");
        var hdnchargecode1 = document.getElementById(pref + "hdnchargecode1");
        var hdnchargecode2 = document.getElementById(pref + "hdnchargecode2");
        
        if(hdnchargecode1.value=="SCHG20")
        {
            txtcharge1.value=roundNumber(fuelsurcharge,2);
        }
        
        if(hdnchargecode2.value=="SCHG20")
        {
            txtcharge2.value=roundNumber(fuelsurcharge,2);
        }
    }   
    
    return false;
}


function viewParty()
{
    var txtpartycode=document.getElementById("ctl00_MyCPH1_txtpartycode");
    if(txtpartycode.value=="")
    {
        alert("No Party Selected...");
        return false;
    }
    else
    {
        window.open("../../Admin/CustomerContractMaster_ver1/ViewCustomerContractStep1.aspx?customercode=" + txtpartycode.value,null,"");
    }
    return false;
}


function calculateProRata()
{
    
    var hdnftlmaxcapacity=document.getElementById("ctl00_MyCPH1_hdnftlmaxcapacity");
    var txtfreightcharge=document.getElementById("ctl00_MyCPH1_txtfreightcharge");
    var txttotchargedweight=document.getElementById("ctl00_MyCPH1_txttotchargedweight");
    var diff=0.00,prorata=0.00;
    if(hdnftlmaxcapacity.value=="")
        hdnfltmaxcapacity.value=="0";
        
        diff=parseFloat(txttotchargedweight.value) - parseFloat(hdnftlmaxcapacity.value)
        if(diff<0)
        {
            diff=0;
        }
        prorata=diff * parseFloat(txtfreightcharge.value) / parseFloat(hdnftlmaxcapacity.value);
        prorata=roundNumber(prorata,2);
        
// NOW ADDING SIMPLE CHARGES
    var grvcharges = document.getElementById("ctl00_MyCPH1_grvcharges");
    var rows=grvcharges.rows.length;
    
    var i=0;
    var pref="";
    for(i=2;i<=rows+1;i++)
    {
        if(i<10)
            pref = "ctl00_MyCPH1_grvcharges_ctl0" + i + "_";
        else
            pref = "ctl00_MyCPH1_grvcharges_ctl" + i + "_";
    
        var txtcharge1 = document.getElementById(pref + "txtcharge1");
        var txtcharge2 = document.getElementById(pref + "txtcharge2");
        var hdnchargecode1 = document.getElementById(pref + "hdnchargecode1");
        var hdnchargecode2 = document.getElementById(pref + "hdnchargecode2");
        
        if(hdnchargecode1.value=="SCHG17")
        {
            txtcharge1.value=prorata;
        }
        
        if(hdnchargecode2.value=="SCHG17")
        {
            txtcharge2.value=prorata;
        }
       
    }       
    
    return false;
}


function submitClick()
	{
	    var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
	    if(hdnajaxstate.value!="0")
	    {
	        alert("Let the internal process over...Try after 5-10 Seconds...");
	        return false;
	    }
	
	    var txtfreightcharge=document.getElementById("ctl00_MyCPH1_txtfreightcharge");
	    var txtfreightrate=document.getElementById("ctl00_MyCPH1_txtfreightrate");
	    var txtsubtotal=document.getElementById("ctl00_MyCPH1_txtsubtotal");
	    var txtdockettotal=document.getElementById("ctl00_MyCPH1_txtdockettotal");
	    var txtbilledat=document.getElementById("ctl00_MyCPH1_txtbilledat");
	    var txtedd=document.getElementById("ctl00_MyCPH1_txtedd");
	    var cmbstaxpaidby=document.getElementById("ctl00_MyCPH1_cmbstaxpaidby");
	    var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");
	    var optcarrierrisk=document.getElementById("ctl00_MyCPH1_optcarrierrisk");
	    var txtfovcharged=document.getElementById("ctl00_MyCPH1_txtfovcharged");
	    var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
	    var dkt_call = document.getElementById("ctl00_MyCPH1_hdndockname").value;
	      
	    if(txtbilledat.value=="")
	    {
	        alert("Billing Location is Not Entered. Can't Book " + dkt_call);
	        return false;
	    }

	    if(txtedd.value=="")
	    {
	        alert("Expected Date of Delivery is not Specifed. Please Enter EDD.");
	        txtedd.focus();
	        return false;
	    }
	    
	    if(cmbstaxpaidby.value=="" || cmbstaxpaidby.value=="0")
	    {
	        alert("Please Select Service Tax Payer.");
	        cmbstaxpaidby.focus();
	        return false;
	    }
	    
	    
	    if(cmbpaybas.value!="P04")
	    {
	        var chkmultipickup=document.getElementById("ctl00_MyCPH1_chkmultipickup");
	        var chkmultidelivery=document.getElementById("ctl00_MyCPH1_chkmultidelivery");
	        if(chkmultipickup.checked==false && chkmultidelivery.checked==false)
	        {
                if(parseFloat(txtfreightcharge.value)==0 || txtfreightcharge.value=="")
                {
                    alert("Freight Amount is Zero. Cannot Enter " + dkt_call);
                    return false;
                }
                
                if(parseFloat(txtfreightrate.value)==0 || txtfreightrate.value=="")
                {
                    alert("Freight Rate is Zero. Cannot Enter " + dkt_call);
                    return false;
                }
            }
            
            
            if(parseFloat(txtsubtotal.value)==0 || txtsubtotal.value=="")
            {
                alert("SubTotal Amount is Zero. Cannot Enter " + dkt_call);
                return false;
            }
            
            if(parseFloat(txtdockettotal.value)==0 || txtdockettotal.value=="")
            {
                alert("Total Amount is Zero. Cannot Enter " + dkt_call);
                return false;
            }
	    }
	    
	    
	    
	   // FROM CONTRACT MASTERS DECIDE MINIMUM CRITERIA
	    var hdnminfreighttype=document.getElementById("ctl00_MyCPH1_hdnminfreighttype");
	    var hdncontractdepth=document.getElementById("ctl00_MyCPH1_hdncontractdepth");
        	    
	    if(hdncontractdepth.value=="M")
	    {
	        if(hdnminfreighttype.value=="%")
	        {
	            if(!calculateMinPercentSubTotal())
                    return false;
                    
                if(!calculateMinimumFreight())
                    return false;
            }
        }

	      // CLIENT SPECIFIC SETTINGS
	    if(hdnclient.value=="RLL")
	    {
	        var chkcoddod = document.getElementById("ctl00_MyCPH1_chkcoddod");
	        var chkdacc = document.getElementById("ctl00_MyCPH1_chkdacc");
	        var chkoda = document.getElementById("ctl00_MyCPH1_chkoda");
	      
	        if(chkcoddod.checked==true)
	        {
	            var txtcoddodcharged=document.getElementById("ctl00_MyCPH1_txtcoddodcharged");
	            if(parseFloat(txtcoddodcharged.value)==0)
	            {
	                
	                alert("COD/DOD Amount can't be Zero...");
	                return false;
	            }
	        }
	        
	        if(chkdacc.checked==true)
	        {
	            var txtdacccharged=document.getElementById("ctl00_MyCPH1_txtdacccharged");
	            if(parseFloat(txtdacccharged.value)==0)
	            {
	                alert("DACC Amount Can't be Zero...");
	                return false;
	            }
	        }
	        
	        if(chkoda.checked==true)
	        {
	            // NOW ADDING SIMPLE CHARGES
                var grvcharges = document.getElementById("ctl00_MyCPH1_grvcharges");
                var rows=grvcharges.rows.length;
                
                    var i=0;
                    var pref="";
                    for(i=2;i<=rows+1;i++)
                    {
                        if(i<10)
                            pref = "ctl00_MyCPH1_grvcharges_ctl0" + i + "_";
                        else
                            pref = "ctl00_MyCPH1_grvcharges_ctl" + i + "_";
                    
                        var txtcharge1 = document.getElementById(pref + "txtcharge1");
                        var txtcharge2 = document.getElementById(pref + "txtcharge2");
                        var hdnchargecode1 = document.getElementById(pref + "hdnchargecode1");
                        var hdnchargecode2 = document.getElementById(pref + "hdnchargecode2");
                        
                        
                        if(hdnchargecode1.value=="SCHG19")
                        {
                            if(parseFloat(txtcharge1.value)==0)
                            {
                                alert("ODA  Amount Can't be Zero...");
                                return false;
                            }
                        }
                	    
                	    if(hdnchargecode2.value=="SCHG19")
                        {
                            if(parseFloat(txtcharge2.value)==0)
                            {
                                alert("ODA  Amount Can't be Zero...");
                                return false;
                            }
                        }   
	                }
             } // ODA if
	    
	    
	    
	            // RLL LOCAL AND EDD
              // date validation not future for all clients
              var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
              var datediff=0;
               
              var txtdockdate=document.getElementById("ctl00_MyCPH1_txtdockdate");
              var arredd=txtedd.value.split('/');
              var arrdockdt=txtdockdate.value.split('/');
              
              
              var dtdockdate=new Date(months[parseFloat(arrdockdt[1])] + " " +  arrdockdt[0] + "," + arrdockdt[2]);
              var dtedd=new Date(months[parseFloat(arredd[1])] + " " +  arredd[0] + "," + arredd[2]);
	          var chklocal=document.getElementById("ctl00_MyCPH1_chklocal");
	          var datediff = MyDateDiff(dtdockdate,dtedd,'D',true);
	         
	          if(chklocal.checked==false)
	          {
	          
	              if(datediff<=0)
	              {
	                    alert("EDD can't be less than or equal to " + dkt_call + " Date");
	                    return false;
	              }
	          }
	         
	              if(dtdockdate>dtedd)
	                  {
	                        alert("EDD can't be less than " + dkt_call + " Date");
	                        return false;
	                  }
	         
	          
	    }  // RLL over
	    
	   
	    
	    
	    if(hdnclient.value=="RITCO")
	    {
	        if(optcarrierrisk.checked==true)
	        {
	            if(txtfovcharged.value=="" || parseFloat(txtfovcharged.value)==0)
	            {
	                alert("For Carrier Risk FOV Charged can't be zero....");
	                txtfovcharged.focus();
	                return false;
	            }
	        }
	    }
	    
	    
	    if(parseFloat(txtdockettotal.value)>50000)
	    {
	        if(!confirm(dkt_call + " Total is greater than 50000 are you want to continue ???"))
	            return false;
	    }
	    
	    
	    if(parseFloat(txtdockettotal.value)>100000)
	    {
	        if(!confirm(dkt_call + " Total is greater than 100000 are you want to continue ???"))
	            return false;
	    }
	    
	    
	    if(!confirm("Are you sure you want to save this " + dkt_call))
	        return false;
	    
	    var btnsubmit=document.getElementById("ctl00_MyCPH1_btnsubmit");
	    btnsubmit.style.display="none";
	    
	    //Enabling all
	    enableAllFins();
	    
	    return true;
	}

	function freightChargeBlur()
	{
	    var txtfreightrate=document.getElementById("ctl00_MyCPH1_txtfreightrate");
	    var txtfreightcharge=document.getElementById("ctl00_MyCPH1_txtfreightcharge");
	    var cmbratetype=document.getElementById("ctl00_MyCPH1_cmbratetype");
	    
	    var txttotchargedweight=document.getElementById("ctl00_MyCPH1_txttotchargedweight");
	    var hdntotnopkgs=document.getElementById("ctl00_MyCPH1_hdntotnopkgs");
    
	    var chkmultipickup=document.getElementById("ctl00_MyCPH1_chkmultipickup");
	    var chkmultidelivery=document.getElementById("ctl00_MyCPH1_chkmultidelivery");
	    
	    

        if(cmbratetype.value=="W")
        {
            txtfreightrate.value=parseFloat(txtfreightcharge.value)/parseFloat(txttotchargedweight.value);
        }
        else if(cmbratetype.value=="P")
        {
            txtfreightrate.value=parseFloat(txtfreightcharge.value)/parseFloat(hdntotnopkgs.value);
        }
        else if(cmbratetype.value=="T")
        {
            txtfreightrate.value=parseFloat(txtfreightcharge.value)/(parseFloat(txttotchargedweight.value)*1000);
        }
        
        txtfreightrate.value=roundNumber(txtfreightrate.value,2);
	    
	    if(chkmultipickup.checked==true || chkmultidelivery.checked==true)
	    {
	        txtfreightrate.value="0.00";
	        txtfreightcharge.value="0.00";
	    }
	    
        var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");	        
        if(parseFloat(txtfreightcharge.value)==0 && cmbpaybas.value!="P04")
        {
            if(chkmultipickup.checked==false && chkmultidelivery.checked==false)
	        {
                alert("Freight Rate Can't be Zero. Please Re-Enter");
                txtfreightcharge.focus();
            }
        }

            /************************************************************************************
                CALCULATING MINIMUM FREIGHT IN CASE OF MANUAL ENTRY
            *************************************************************************************/
	        if(!calculateMinimumFreight())
	        {
	            
	        }
	    
	    // calculate fuel surcharge
	    calculateFuelSurCharge();
	    
	    //Calculating Subtotal
	    calculateSubTotal();
	    
	    return false;
	}
	
	
	
	
	function calculateMinimumFreight()
	{
	       var hdnminfreighttype=document.getElementById("ctl00_MyCPH1_hdnminfreighttype");	  
    
           if(hdnminfreighttype.value=="B")
           {
                if(!calculateMinBasFreight())
                    return false;
           }
           else if(hdnminfreighttype.value=="%")
           {
                if(!calculateMinPercentFreight())
                    return false;
           }    
           else
           {
                return false;
           }
            
	    return true;
	}
	
	
	function calculateMinBasFreight()
	{

	       var hdnminfreightbas=document.getElementById("ctl00_MyCPH1_hdnminfreightbas");	  
	       var hdnminfreightbasrate=document.getElementById("ctl00_MyCPH1_hdnminfreightbasrate");	 

           var txtfreightrate=document.getElementById("ctl00_MyCPH1_txtfreightrate");	  
           var txtfreightcharge=document.getElementById("ctl00_MyCPH1_txtfreightcharge");
           var cmbratetype=document.getElementById("ctl00_MyCPH1_cmbratetype");	  	  
           var txttotchargedweight=document.getElementById("ctl00_MyCPH1_txttotchargedweight");	  
           var hdntotnopkgs=document.getElementById("ctl00_MyCPH1_hdntotnopkgs");	  
           var hdndbfreightrate=document.getElementById("ctl00_MyCPH1_hdndbfreightrate");	
    
            var minfreight=0.00;
            if(hdnminfreightbas.value=="RS")
            {
                minfreight=parseFloat(hdnminfreightbasrate.value);
                alert("Minimum Freight in RS applied.");
            }
            else if(hdnminfreightbas.value=="KG" || hdnminfreightbas.value=="PKG" || hdnminfreightbas.value=="T")
            {
                minfreight=parseFloat(hdndbfreightrate.value)*parseFloat(hdnminfreightbasrate.value);
                alert("Minimum Freight in " + hdnminfreightbas.value + " applied.");
            }
            
            if(parseFloat(txtfreightcharge.value)<minfreight)
                txtfreightcharge.value=roundNumber(minfreight,2);
            	        
            if(cmbratetype.value=="W")
                txtfreightrate.value=parseFloat(txtfreightcharge.value)/parseFloat(txttotchargedweight.value);
            else if(cmbratetype.value=="P")
                txtfreightrate.value=parseFloat(txtfreightcharge.value)/parseFloat(hdntotnopkgs.value);
            else if(cmbratetype.value=="T")
                txtfreightrate.value=parseFloat(txtfreightcharge.value)/(parseFloat(txttotchargedweight.value)*1000);
            else
                return false;
                    
                txtfreightrate.value=roundNumber(txtfreightrate.value,2);
                txtfreightcharge.value=roundNumber(txtfreightcharge.value,2);
                
          return true;
	}
	
	function calculateMinPercentSubTotal()
	{
	       var hdnflagminsubtotalper=document.getElementById("ctl00_MyCPH1_hdnflagminsubtotalper");
	       if(hdnflagminsubtotalper.value=="N"  || hdnflagminsubtotalper.value=="")
	            return true;

	       var txtsubtotal=document.getElementById("ctl00_MyCPH1_txtsubtotal");	  
	       var hdnyieldsubtotalrate=document.getElementById("ctl00_MyCPH1_hdnyieldsubtotalrate");	
	       
	       var cmbratetype=document.getElementById("ctl00_MyCPH1_cmbratetype");	  	  
	       var txttotchargedweight=document.getElementById("ctl00_MyCPH1_txttotchargedweight");	  
           var hdntotnopkgs=document.getElementById("ctl00_MyCPH1_hdntotnopkgs");	
             
	       var hdnminsubtotal=document.getElementById("ctl00_MyCPH1_hdnminsubtotal");	  
	       var hdnlowlimsubtotal=document.getElementById("ctl00_MyCPH1_hdnlowlimsubtotal");	  
	       var hdnupplimsubtotal=document.getElementById("ctl00_MyCPH1_hdnupplimsubtotal");	
	       
	       var lowlim=0.00,upplim=0.00,newrate=0.00;
	       lowlim=parseFloat(hdnyieldsubtotalrate.value)*parseFloat(hdnlowlimsubtotal.value)/100;
           upplim=parseFloat(hdnyieldsubtotalrate.value)*parseFloat(hdnupplimsubtotal.value)/100;
           
           
            if(cmbratetype.value=="W")
                newrate=parseFloat(txtsubtotal.value)/parseFloat(txttotchargedweight.value);
            else if(cmbratetype.value=="P")
                newrate=parseFloat(txtsubtotal.value)/parseFloat(hdntotnopkgs.value);
            else if(cmbratetype.value=="T")
                newrate=parseFloat(txtsubtotal.value)/(parseFloat(txttotchargedweight.value)*1000);
            else
                return false;
           
           
           if(newrate<lowlim)
           {
                alert("Subtotal Yield is less than Minimum Subtotal Limit i.e. " + hdnlowlimsubtotal.value + "%");
                return false;
           }
           
           if(newrate>upplim)
           {
                alert("SubTotal Yield is more than Maximum Subtotal Limit i.e." + hdnupplimsubtotal.value + "%");
                return false;
           }
           
           
           if(parseFloat(txtsubtotal.value)<parseFloat(hdnminsubtotal.value))
           {
                alert("SubTotal is Less than Minimum Subtotal(in RS.) i.e. " + hdnminsubtotal.value + " RS");
                return false;
           }
           
       
	    return true;
	}
	
	function calculateMinPercentFreight()
	{
	        
	       var hdnflagminfreightper=document.getElementById("ctl00_MyCPH1_hdnflagminfreightper");
	       if(hdnflagminfreightper.value=="N"  || hdnflagminfreightper.value=="")
	            return true;
	
	       var txtfreightrate=document.getElementById("ctl00_MyCPH1_txtfreightrate");	  
           var txtfreightcharge=document.getElementById("ctl00_MyCPH1_txtfreightcharge");
           var cmbratetype=document.getElementById("ctl00_MyCPH1_cmbratetype");	  	  
           var txttotchargedweight=document.getElementById("ctl00_MyCPH1_txttotchargedweight");	  
           var hdntotnopkgs=document.getElementById("ctl00_MyCPH1_hdntotnopkgs");	  
           var hdndbfreightrate=document.getElementById("ctl00_MyCPH1_hdndbfreightrate");	
           
           var hdnminfreightrate=document.getElementById("ctl00_MyCPH1_hdnminfreightrate");	  
	       var hdnlowlimfreightrate=document.getElementById("ctl00_MyCPH1_hdnlowlimfreightrate");	  
	       var hdnupplimfreightrate=document.getElementById("ctl00_MyCPH1_hdnupplimfreightrate");	
	      
	       
	       var lowlim=0.00,upplim=0.00;
	       lowlim=parseFloat(hdndbfreightrate.value)*parseFloat(hdnlowlimfreightrate.value)/100;
           upplim=parseFloat(hdndbfreightrate.value)*parseFloat(hdnupplimfreightrate.value)/100;
           
           
           if(parseFloat(txtfreightrate.value)<lowlim)
           {
                alert("Freight Rate Lower Limit Reached. Lower Freight Rate Applied.");
                txtfreightrate.value=roundNumber(lowlim,2);
           }
           
           if(parseFloat(txtfreightrate.value)>upplim)
           {
                alert("Freight Rate Upper Limit Reached. Upper Freight Rate Applied.");
                txtfreightrate.value=roundNumber(upplim,2);
           }
           
           
            if(cmbratetype.value=="W")
                txtfreightcharge.value=parseFloat(txtfreightrate.value)*parseFloat(txttotchargedweight.value);
            else if(cmbratetype.value=="P")
                txtfreightcharge.value=parseFloat(txtfreightrate.value)*parseFloat(hdntotnopkgs.value);
            else if(cmbratetype.value=="T")
                txtfreightcharge.value=parseFloat(txtfreightrate.value)* (parseFloat(txttotchargedweight.value)/1000);
            else
                return false;
                    
            txtfreightrate.value=roundNumber(txtfreightrate.value,2);
            txtfreightcharge.value=roundNumber(txtfreightcharge.value,2);
            
           
           
           //  Now Checking Flat Minimum
           if(parseFloat(txtfreightcharge.value)<parseFloat(hdnminfreightrate.value))
           {
                alert("Minimum Freight in RS applied");
                txtfreightcharge.value=roundNumber(hdnminfreightrate.value,2);
                
                if(cmbratetype.value=="W")
                    txtfreightrate.value=parseFloat(txtfreightcharge.value)/parseFloat(txttotchargedweight.value);
                else if(cmbratetype.value=="P")
                    txtfreightrate.value=parseFloat(txtfreightcharge.value)/parseFloat(hdntotnopkgs.value);
                else if(cmbratetype.value=="T")
                    txtfreightrate.value=parseFloat(txtfreightcharge.value)/(parseFloat(txttotchargedweight.value)*1000);
                else
                    return false;
               
                txtfreightrate.value=roundNumber(txtfreightrate.value,2);
                txtfreightcharge.value=roundNumber(txtfreightcharge.value,2);
               
           }
           
           return true;
	}
	
	
		
	
	function freightRateBlur()
	{
	    
	    var txtfreightrate=document.getElementById("ctl00_MyCPH1_txtfreightrate");
	    var txtfreightcharge=document.getElementById("ctl00_MyCPH1_txtfreightcharge");
	    var cmbratetype=document.getElementById("ctl00_MyCPH1_cmbratetype");
	    
	    var txttotchargedweight=document.getElementById("ctl00_MyCPH1_txttotchargedweight");
	    var hdntotnopkgs=document.getElementById("ctl00_MyCPH1_hdntotnopkgs");
	    
	    txtfreightrate.value=roundNumber(parseFloat(txtfreightrate.value),2);
	     
	    var chkmultipickup=document.getElementById("ctl00_MyCPH1_chkmultipickup");
	    if(chkmultipickup.checked==true)
	    {
	        txtfreightrate.value="0.00";
	        txtfreightcharge.value="0.00";
	    }
	    
	    var freight=0.00;
	    if(cmbratetype.value=="P")
	    {
	        freight = parseFloat(hdntotnopkgs.value) * parseFloat(txtfreightrate.value);
	    }
	    else if(cmbratetype.value=="W")
	    {
	        freight = parseFloat(txttotchargedweight.value) * parseFloat(txtfreightrate.value);
	    }
	    else if(cmbratetype.value=="T")
	    {
	        freight = parseFloat(txttotchargedweight.value) * parseFloat(txtfreightrate.value) / 1000 ;
	    }
	    else if(cmbratetype.value=="F")
	        freight = parseFloat(txtfreightrate.value);
	        
	        txtfreightcharge.value=roundNumber(freight,2);
            /************************************************************************************
                CALCULATING MINIMUM FREIGHT IN CASE OF MANUAL ENTRY
            *************************************************************************************/
	        calculateMinimumFreight();
	    
	        var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");
	        if(parseFloat(txtfreightcharge.value)==0 && cmbpaybas.value!="P04")
	        {
	            alert("Freight Can't be Zero. Please Re-Enter");
	        }
	        
	    // calculate fuel surcharge
	    calculateFuelSurCharge();
	
	    //Calculating Subtotal
	    calculateSubTotal();
	    
	    return false;
	}
		
	
// THIS FUNCTION IS USED WHEN SERVICE TYPE GETS CHANGED
function serviceChange()
{
    var cmbservicetype = document.getElementById("ctl00_MyCPH1_cmbservicetype");
    var cmbftltype = document.getElementById("ctl00_MyCPH1_cmbftltype");
    var trmultipoint = document.getElementById("ctl00_MyCPH1_trmultipoint");
    var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
    
    if(cmbservicetype.value=="1")
         {
            cmbftltype.disabled=true;
            cmbftltype.value="0";
            trmultipoint.style.display="none";
         }
    else if(cmbservicetype.value=="2")
         {
            cmbftltype.disabled=false;
            if(hdnclient.value=="AGILITY")
                trmultipoint.style.display="block";
         }
   
   
   
}
	
function selectMPSource(dockno)
{
  var txtsource=document.getElementById("ctl00_MyCPH1_txtsourcedockno");
  var divmpsources=document.getElementById("ctl00_MyCPH1_divmpsources");
  txtsource.value=dockno;
  divmpsources.style.display="none";
  return false;
}

function openSources()
{
    
    var divmpsources=document.getElementById("ctl00_MyCPH1_divmpsources");
     divmpsources.style.display="block";
     return false;
}


function multiPickUpClick()
{
    var chkmultipickup=document.getElementById("ctl00_MyCPH1_chkmultipickup");
    var chkmultidelivery=document.getElementById("ctl00_MyCPH1_chkmultidelivery");
    var txtsourcedockno=document.getElementById("ctl00_MyCPH1_txtsourcedockno");
    var imgsourcedock=document.getElementById("ctl00_MyCPH1_imgsourcedock");
    var lblsourcedockname=document.getElementById("ctl00_MyCPH1_lblsourcedockname");
    
           if(chkmultipickup.checked==true || chkmultidelivery.checked==true)
           {
                txtsourcedockno.style.display="block";
                imgsourcedock.style.display="block";
                lblsourcedockname.style.display="block";
           }
           else
           {
                txtsourcedockno.style.display="none";
                imgsourcedock.style.display="none";
                lblsourcedockname.style.display="none";
           }
    return true;
}
	
	
function validateStep1()
{

     var hdnajaxstate=document.getElementById("ctl00_MyCPH1_hdnajaxstate");
        if(hdnajaxstate.value!="0")
        {
            alert("Let the internal process over...Try after 5-10 Seconds...");
            return false;
        }


  var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
  var hdnserverdate=document.getElementById("ctl00_MyCPH1_hdnserverdate");      
  var txtdockno=document.getElementById("ctl00_MyCPH1_txtdockno");
  var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");
  var txtpartycode=document.getElementById("ctl00_MyCPH1_txtpartycode");
  var txtpartyname=document.getElementById("ctl00_MyCPH1_txtpartyname");
  var txtdelloc=document.getElementById("ctl00_MyCPH1_txtdelloc");
  var divdisable=document.getElementById("ctl00_MyCPH1_divdisable");
  var divstep1=document.getElementById("ctl00_MyCPH1_divstep1");
  var dkt_call = document.getElementById("ctl00_MyCPH1_hdndockname").value;
  
 
   //Empty Check
  if(txtdockno.value=="")
  {
        alert("Please Enter " + dkt_call + " Number....");
        txtdockno.select();
        return false;
  }
  
  var txtdockdate=document.getElementById("ctl00_MyCPH1_txtdockdate");
  if(txtdockdate.value=="")
  {
    alert("Please Enter " + dkt_call + " Date.....");
    txtdockdate.select();
    return false;
  }
  
  // date validation not future for all clients
  var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
  var datediff=0;
  
  var arrserverdate=hdnserverdate.value.split('/');
  var arrdockdt=txtdockdate.value.split('/');
  
  var dtserverdate=new Date(months[parseFloat(arrserverdate[1])] + " " +  arrserverdate[0] + "," + arrserverdate[2]);
  var dtdockdate=new Date(months[parseFloat(arrdockdt[1])] + " " +  arrdockdt[0] + "," + arrdockdt[2]);

  //if date2 > date1  then returns positive
  datediff=MyDateDiff(dtserverdate,dtdockdate,'D',true);
  var hdnserverhour=document.getElementById("ctl00_MyCPH1_hdnserverhour");
 
    if(hdnclient.value=="ASL")
    {
       if(datediff>1)
          {
            alert(dkt_call + " Date can't be greater than Today's Date. Please Enter another Date.");
            txtdockdate.value="";
            txtdockdate.focus();
            return false;
          }
       
        if(datediff<-1)
        {
            alert(dkt_call + " Date can't be lest than Yesterday. Please Enter another Date.");
            txtdockdate.value="";
            txtdockdate.focus();
            return false;
        }
        
        if(datediff==-1)
        {
            if(parseFloat(hdnserverhour.value)>12)
            {
                alert(dkt_call + " Date/Time is less than Back Dated range. Can't allow");
                txtdockdate.value="";
                txtdockdate.focus();
                return false;
            }
        }
        
        if(datediff==1)
        {
            if(parseFloat(hdnserverhour.value)<12)
            {
                alert(dkt_call + " Date/Time is more than Future range. Can't allow");
                txtdockdate.value="";
                txtdockdate.focus();
                return false;
            }
        }  
    }
    else
    {
        if(datediff>0)
          {
            alert(dkt_call + " Date can't be greater than Today's Date. Please Enter another Date.");
            txtdockdate.value="";
            txtdockdate.focus();
            return false;
          }
    }
  
  if(!bookingDateEntryTime())
    return false;
  
  if(cmbpaybas.value=="0")
  {
    alert("Please Select Payment Type....");
    cmbpaybas.focus();
    return false;
  }
  
    var hdncontractsets=document.getElementById("ctl00_MyCPH1_hdncontractsets");
    var arrsets=hdncontractsets.value.split(',');
    
    switch(cmbpaybas.value)
    {
    
        case "P01":
                    if(arrsets[0]=="C")
                    {
                        if(txtpartycode.value=="")
                        {
                            alert("Please Enter Party Code");
                            txtpartycode.focus();
                            return false;
                        }
                    }
                    break;
        case "P02":
                    if(arrsets[1]=="C")
                    {
                        if(txtpartycode.value=="")
                        {
                            alert("Please Enter Party Code");
                            txtpartycode.focus();
                            return false;
                        }
                    }
                    break;
        case "P03":
                    if(arrsets[2]=="C")
                    {
                        if(txtpartycode.value=="")
                        {
                            alert("Please Enter Party Code");
                            txtpartycode.focus();
                            return false;
                        }
                    }
                    break;
    }
  
  
  if(txtdelloc.value=="")
  {
    alert("Please Enter Delivery Location....");
    txtdelloc.select();
    return false;
  }
  
  
  if(!isValidDate(txtdockdate.value,dkt_call))
  {
    txtdockdate.select();
    return false;
  }
  
  
  var trpickupdel = document.getElementById("ctl00_MyCPH1_trpickupdel");
  var trtransmode = document.getElementById("ctl00_MyCPH1_trtransmode");
  var trpacktype = document.getElementById("ctl00_MyCPH1_trpacktype");
  var trbtnstep2 = document.getElementById("ctl00_MyCPH1_trbtnstep2");
  
  
  trpickupdel.style.display="block";
  trtransmode.style.display="block";
  trpacktype.style.display="block";
  trbtnstep2.style.display="block";
  
  return true;
}
	
	
	
	
	
	// Inner Function to be called on all simple charges including COD/DOD, DACC
	function chargeBlur(id)
	{
	    var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
	    var txtcharge = document.getElementById(id);
	    var hdndefaultfov=document.getElementById("ctl00_MyCPH1_hdndefaultfov");
	    var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");
	  
	    if(id=="ctl00_MyCPH1_txtfovcharged")
	    {
	        if(hdnclient.value=="RCPL")
            {
                if(cmbpaybas.value=="P01" || cmbpaybas.value=="P03")
                {
                    if(parseFloat(txtcharge.value)<parseFloat(hdndefaultfov.value))
                    {
                        alert("FOV Charge can't be less than Default Charge");
                        txtcharge.value=hdndefaultfov.value;
                    }
                }      
            }
        }
	    
	    
	    // Rounding Charge Off
	    txtcharge.value=roundNumber(parseFloat(txtcharge.value),2);
	    
	    // Calculating Subtotal
	    calculateSubTotal();
	    return false;
	}

    function gridChargeBlur(id)
    {
        var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
        var hdnid=id.replace("txtcharge","hdnchargevalue")
        var txtcharge=document.getElementById(id);
        var hdncharge=document.getElementById(hdnid);
        
        var tc=roundNumber(txtcharge.value,2);
        var hc=roundNumber(hdncharge.value,2);
        
        txtcharge.value=tc;
        if(hdnclient.value=="RCPL")
        {
            if(parseFloat(tc) < parseFloat(hc))
            {
                alert("Can't Insert Charge Less than " + hdncharge.value);
                txtcharge.focus();
                return false;
            }
        }
        // Calculating Subtotal
	    calculateSubTotal();
	    return false;
    }

	
function calculateFOV()
{
    var txtfovrate = document.getElementById("ctl00_MyCPH1_txtfovrate");
    var txtfovcalculated = document.getElementById("ctl00_MyCPH1_txtfovcalculated");
    var txtfovcharged = document.getElementById("ctl00_MyCPH1_txtfovcharged");
    
    var hdntotdeclval = document.getElementById("ctl00_MyCPH1_hdntotdeclval");
    var fovcharge=0.00;
    
    // Rounding FOVRate off
    txtfovrate.value=roundNumber(parseFloat(txtfovrate.value),2);
    
    fovcharge = parseFloat(hdntotdeclval.value) * parseFloat(txtfovrate.value) / 100;
    
    txtfovcalculated.value=roundNumber(fovcharge,2);
    txtfovcharged.value=roundNumber(fovcharge,2);
   
    var hdndefaultfov=document.getElementById("ctl00_MyCPH1_hdndefaultfov");
	var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");
    var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
   
        if(hdnclient.value=="RCPL")
            {
                if(cmbpaybas.value=="P01" || cmbpaybas.value=="P03")
                {
                    if(parseFloat(txtfovcharged.value)<parseFloat(hdndefaultfov.value))
                    {
                        alert("FOV Charge can't be less than Default Charge");
                        txtfovcharged.value=hdndefaultfov.value;
                        txtfovrate.value=parseFloat(hdndefaultfov.value)/parseFloat(hdntotdeclval.value);
                    }
                }      
            }
   
   // After Getting Fov we need to make SubTotal Again
   calculateSubTotal();
   
    return false;
}
	
function calculateSubTotal()
{
    var subtotal=0.00;
    var txtsubtotal = document.getElementById("ctl00_MyCPH1_txtsubtotal");
    
    var txtfreightcharge = document.getElementById("ctl00_MyCPH1_txtfreightcharge");
    var txtfovcharged = document.getElementById("ctl00_MyCPH1_txtfovcharged");
    var txtcoddodcharged = document.getElementById("ctl00_MyCPH1_txtcoddodcharged");
    var txtdacccharged = document.getElementById("ctl00_MyCPH1_txtdacccharged");
    var hdnclient = document.getElementById("ctl00_MyCPH1_hdnclient");
    var chkcoddod = document.getElementById("ctl00_MyCPH1_chkcoddod");
    var chkdacc = document.getElementById("ctl00_MyCPH1_chkdacc");
    
    subtotal = parseFloat(txtfreightcharge.value);
    subtotal = subtotal + parseFloat(txtfovcharged.value);
    
    
    if(txtcoddodcharged.value=="")
       txtcoddodcharged.value="0.00";
       
    if(txtfovcharged.value=="")
       txtfovcharged.value="0.00";

    if(txtdacccharged.value=="")
       txtdacccharged.value="0.00";

    
    if(chkcoddod.checked==true)
        subtotal = subtotal + parseFloat(txtcoddodcharged.value);
    
    if(chkdacc.checked==true)
        subtotal = subtotal + parseFloat(txtdacccharged.value);
    
    /////////////////// AGILITY PRORATA
        var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
        if(hdnclient.value=="AGILITY")
        {
            var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");
            if(cmbpaybas.value=="P02")
            {
                calculateProRata();
            }
        }
    ///////////////////
    
    // NOW ADDING SIMPLE CHARGES
    var grvcharges = document.getElementById("ctl00_MyCPH1_grvcharges");
    var rows=grvcharges.rows.length;
    
    var i=0;
    var pref="";
    for(i=2;i<=rows+1;i++)
    {
        if(i<10)
            pref = "ctl00_MyCPH1_grvcharges_ctl0" + i + "_";
        else
            pref = "ctl00_MyCPH1_grvcharges_ctl" + i + "_";
    
        var txtcharge1 = document.getElementById(pref + "txtcharge1");
        var txtcharge2 = document.getElementById(pref + "txtcharge2");
        var hdnchargecode1 = document.getElementById(pref + "hdnchargecode1");
        var hdnchargecode2 = document.getElementById(pref + "hdnchargecode2");
        
        if(txtcharge1.value=="" || isNaN(txtcharge1.value))
            txtcharge1.value="0.00";
            
        if(txtcharge2.value=="" || isNaN(txtcharge2.value))
            txtcharge2.value="0.00";
               
        if(hdnchargecode1.value!="UCHG06" && hdnchargecode1.value!="UCHG07" && hdnchargecode1.value!="UCHG08" && hdnchargecode1.value!="UCHG09" && hdnchargecode1.value!="UCHG10")
            subtotal = subtotal + parseFloat(txtcharge1.value);
        else
            subtotal = subtotal - parseFloat(txtcharge1.value);
            
        if(hdnchargecode2.value!="UCHG06" && hdnchargecode2.value!="UCHG07" && hdnchargecode2.value!="UCHG08" && hdnchargecode2.value!="UCHG09" && hdnchargecode2.value!="UCHG10")
            subtotal = subtotal + parseFloat(txtcharge2.value);
        else
            subtotal = subtotal - parseFloat(txtcharge2.value);
    }
    
    
    if(hdnclient.value=="RITCO" || hdnclient.value=="TLL" || hdnclient.value=="ASL")
        txtsubtotal.value = Math.round(subtotal);       
    else
        txtsubtotal.value = roundNumber(subtotal,2);
    
    
    
    // AFTER CALCULATING SUBTOTAL CALCULATE SERVICETAX AND DOCKET TOTAL
    calculateServiceTax();
    
    return false;
}	
	
	
function calculateServiceTax()
{

    var servicetaxrate = parseFloat(document.getElementById("ctl00_MyCPH1_lblservicetaxrate").innerText);
    var cessrate = parseFloat(document.getElementById("ctl00_MyCPH1_lbleducessrate").innerText);
    var hcessrate = parseFloat(document.getElementById("ctl00_MyCPH1_lblheducessrate").innerText);
    var hdnclient = document.getElementById("ctl00_MyCPH1_hdnclient");
        
    // Displaying Error if Service Tax is not Proper
    
    if(isNaN(servicetaxrate) || servicetaxrate==0)
    {
        alert("Service Tax is not Proper. Invalid DataBase.");
        return false;
    }
    
    if(isNaN(cessrate) || cessrate==0)
    {
        alert("Education Cess Rate is not Proper. Invalid DataBase.");
        return false;
    }
  
    if(isNaN(hcessrate) || hcessrate==0)
    {
        alert("Higher Education Cess Rate is not Proper. Invalid DataBase.");
        return false;
    }
    
    
    var txtsubtotal=document.getElementById("ctl00_MyCPH1_txtsubtotal");
    var txtdockettotal=document.getElementById("ctl00_MyCPH1_txtdockettotal");
    
    var cmbservicetype=document.getElementById("ctl00_MyCPH1_cmbservicetype");
    var cmbtransmode=document.getElementById("ctl00_MyCPH1_cmbtransmode");
    var cmbstaxpaidby=document.getElementById("ctl00_MyCPH1_cmbstaxpaidby");
    
    var subtotal=0.00;
    var dockettotal=0.00;
    var servicetax=0.00;
    var cess=0.00;
    var hcess=0.00;
    
    subtotal=parseFloat(txtsubtotal.value);

    // CALCULATING TAXES ON BASE OF TRANSPORT MODE AND SERVICE TYPE BEING USED
    if(cmbtransmode.value=="2") // if transmode is ROAD then service tax is 3 in following conditions
    {
        if(cmbservicetype.value=="1" && subtotal > 750)
        {
            servicetax = subtotal * 3/100;
            cess=servicetax * cessrate / 100;
            hcess=servicetax * hcessrate / 100;
        }
        else if(cmbservicetype.value=="2" && subtotal > 1500)
        {
            servicetax = subtotal * 3/100;
            cess=servicetax * cessrate / 100;
            hcess=servicetax * hcessrate / 100;
        }
        else
        {
            servicetax=0.00;
            cess=0.00;
            hcess=0.00;
        }
    }
    else  // if transport mode is other than road then straight tax from database are applied
    {
        servicetax = subtotal * servicetaxrate / 100;
        cess = servicetax * cessrate / 100;
        hcess = servicetax * hcessrate / 100;
    }
    
    
    var txtservicetaxsub = document.getElementById("ctl00_MyCPH1_txtservicetaxsub");
    var txteducesssub = document.getElementById("ctl00_MyCPH1_txteducesssub");
    var txtheducesssub = document.getElementById("ctl00_MyCPH1_txtheducesssub");
    
    var txtservicetax = document.getElementById("ctl00_MyCPH1_txtservicetax");
    var txteducess = document.getElementById("ctl00_MyCPH1_txteducess");
    var txtheducess = document.getElementById("ctl00_MyCPH1_txtheducess");
    
    if(cmbstaxpaidby.value=="T" || cmbstaxpaidby.value=="Transporter")
      {
          if(hdnclient.value=="RITCO" || hdnclient.value=="TLL" || hdnclient.value=="ASL")
          {
                txtservicetax.value=Math.round(servicetax);
                txteducess.value=Math.round(cess);
                txtheducess.value=Math.round(hcess);
          }
          else
          {
                txtservicetax.value=roundNumber(servicetax,2);
                txteducess.value=roundNumber(cess,2);
                txtheducess.value=roundNumber(hcess,2);
          }
      }
    else
    {
            txtservicetax.value = "0.00";
            txteducess.value = "0.00";
            txtheducess.value = "0.00";
    } 
      
      if(hdnclient.value=="RITCO" || hdnclient.value=="TLL" || hdnclient.value=="ASL")
      {
          txtservicetaxsub.value=Math.round(servicetax);
          txteducesssub.value=Math.round(cess);
          txtheducesssub.value=Math.round(hcess);
      }
      else
      {
          txtservicetaxsub.value=roundNumber(servicetax,2);
          txteducesssub.value=roundNumber(cess,2);
          txtheducesssub.value=roundNumber(hcess,2);
      }

      //ASSIGNING GRAND TOTAL
      dockettotal = parseFloat(subtotal) + parseFloat(txtservicetax.value) + parseFloat(txteducess.value) + parseFloat(txtheducess.value);
      
      if(hdnclient.value=="RITCO" || hdnclient.value=="TLL" || hdnclient.value=="ASL")
          txtdockettotal.value = Math.round(dockettotal);
      else
          txtdockettotal.value = roundNumber(dockettotal,2);
          
    return false;
}



function openDockHelp()
{
    var divdockhelp=document.getElementById("ctl00_MyCPH1_divdockhelp");
        divdockhelp.style.display="block";

   return false;
}

function dockNoCriteriaSubmit()
{
    var divloading=document.getElementById("ctl00_MyCPH1_divloading");
    divloading.style.display="block";
    
    var tblcriteria=document.getElementById("ctl00_MyCPH1_tblcriteria");
    tblcriteria.style.display="none";
    
    return true;
}

    </script>

</asp:Content>
