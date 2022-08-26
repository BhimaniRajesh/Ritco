<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="MFCreateMain.aspx.cs" Inherits="GUI_Operations_Manifest_MFCreateMain"
    Title="Untitled Page" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:SqlDataSource ID="MySQLDataSource_TransModes" runat="server" SelectCommand="usp_TransMode"
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_Cities" runat="server" SelectCommand="usp_Cities"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="-" Name="brcd" Type="String" />
            <asp:Parameter DefaultValue="-" Name="book_dely" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_Regions" runat="server" SelectCommand="usp_Regions"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="xxx" Name="brcd" SessionField="brcd" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <table cellspacing="1" style="width: 700px">
        <tr style="background-color: white">
            <td align="left" width="75%">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Generate <%=strDocumentMF%>:</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
            <td align="left">
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
                &nbsp;&nbsp;&nbsp;
            </td>
        </tr>
    </table>
    <br />
    <script language="javascript" type="text/javascript" src="./../../images/commonJs.js"></script>
    <script src="../../Js/CalendarPopup.js" language="javascript" type="text/javascript"></script>
    <script src="../../Js/AssignValue.js" language="javascript" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">

        function CHKREC() {
            var GV_frmname = "ctl00_MyCPH1_dgDockets_";
            var GV = document.getElementById("ctl00_MyCPH1_dgDockets");
            var rno = parseInt(GV.rows.length) + 1;
            var pref = "";
            var chkcount = 0;
            for (var ij = 2; ij < rno; ij++) {
                if (ij < 10)
                    pref = GV_frmname + "ctl0" + ij + "_";
                else
                    pref = GV_frmname + "ctl" + ij + "_";

                var chk = document.getElementById(pref + "chkDocket");

                if (chk.checked == true) {
                    chkcount++;
                }
            }
            if (chkcount == 0) {
                alert("No Row Selected..........");
                return false;
            }

            document.getElementById("ctl00_MyCPH1_btnPrepareManifest").style.display = "none";

        }


    function SelectAll(CheckBoxControl) {
        if (CheckBoxControl.checked == true) {
            var i;
            for (i = 0; i < document.forms[0].elements.length; i++) {
                if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('dgDockets') > -1)) {
                    document.forms[0].elements[i].checked = true;
                }
            }
        }
        else {
            var i;
            for (i = 0; i < document.forms[0].elements.length; i++) {
                if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('dgDockets') > -1)) {
                    document.forms[0].elements[i].checked = false;
                }
            }
        }
        calculateTotWeight();
    } 	
    var months = new Array("","January", "February", "March", "April", "May", "June",
	                       "July", "August", "September", "October", "November", "December");

	    function DATACHECK() {
            //alert("script started")
            var txtDocumentDate=document.getElementById("ctl00_MyCPH1_txtDocumentDate");
            var txtNextStopcd=document.getElementById("ctl00_MyCPH1_txtNextStop");
             
            var dt =txtDocumentDate.value			
            //alert(dt)
            var dt_dd=dt.substring(0,2)	
            var dt_mm=dt.substring(3,5)
            var dt_yy=dt.substring(6,10)

            var mfdt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))

            currdate = '<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>';
            dt_dd=currdate.substring(0,2)
            dt_mm=currdate.substring(3,5)
            dt_yy=currdate.substring(6,10)
            //alert("hi")
            currdate=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
            	
            //alert(currdate)
            if (currdate < mfdt) {
                alert("MF Date should be less than or equal to  system Date \n")
                txtDocumentDate.focus();
                return false;
            }
            if (txtNextStopcd.value == "") {
                alert("Plz Enter Next Stop Location")
                txtNextStopcd.focus();
                return false;
            }
            if (txtDocumentDate.value == "") {
                alert("Plz Enter MF Date")
                txtDocumentDate.focus();
                return false;
            }
            //alert("script end");
            return true;
	    }

	    function CHK_WT(arwt) {
	        var ctrlID = arwt.getAttribute('ID');

	        var chgwt = document.getElementById(ctrlID.replace("txtWt", "hdwt"));
	        var chgpkg = document.getElementById(ctrlID.replace("txtWt", "hdpkgsno"));
	        var Arrpkg = document.getElementById(ctrlID.replace("txtWt", "txtPkgs"));

	        if (parseFloat(chgwt.value) <= parseFloat(arwt.value)) {
	            alert("Weight Should Be  Less Than " + chgwt.value)
	            //arwt.value=chgwt.value;
	            arwt.value = Math.round((parseFloat(chgwt.value) * parseInt(Arrpkg.value)) / parseInt(chgpkg.value));
	            //arwt.value = Math.round((parseFloat(chgwt.value) / parseInt(chgpkg.value)) * parseInt(Arrpkg.value));
	            arwt.focus();
	            return false;
	        }
	        calculateTotWeight();
	        return true;
	    }

	    function ENABLED_WT(chkpkg) {
	        // alert(chkpkg.value)
	        var ctrlID = chkpkg.getAttribute('ID');
	        
	        var chgpkg = document.getElementById(ctrlID.replace("txtPkgs", "hdpkgsno"));
	        var hgwt = document.getElementById(ctrlID.replace("txtPkgs", "hdwt"));
	        var arwt = document.getElementById(ctrlID.replace("txtPkgs", "txtWt"));

	        if (parseInt(chkpkg.value) > 0) {
	            if (parseInt(chgpkg.value) < parseInt(chkpkg.value)) {
	                alert("Arrived Pkgsno Should Be  Less Than " + chgpkg.value)
	                arwt.disabled = true;
	                chkpkg.value = chgpkg.value;
	                chkpkg.focus();
	                return false;
	            }
	            else {
	                arwt.value = Math.round((parseFloat(chkpkg.value) * parseInt(hgwt.value))/ parseInt(chgpkg.value));
	                arwt.disabled = false;
	            }

	            if (parseInt(chgpkg.value) == parseInt(chkpkg.value)) {
	                arwt.disabled = true;
	                arwt.value = chgwt.value;
	            }
	        }
	        else {
	            alert("Arrived Pkgsno Should Be  Greter Than 0")
	            arwt.disabled = true;

	            chkpkg.value = chgpkg.value;
	            chkpkg.focus();
	            return false;
	        }
	        calculateTotWeight();
	        return true;
	    }

        function calculateTotWeight()
        {
            var GV_frmname = "ctl00_MyCPH1_dgDockets_";
            var GV = document.getElementById("ctl00_MyCPH1_dgDockets");
            var lblTOTWT = document.getElementById("ctl00_MyCPH1_lblTOTWT");
            var HIDTOTWT = document.getElementById("ctl00_MyCPH1_HIDTOTWT");
            var DDLWTADJ = document.getElementById("ctl00_MyCPH1_DDLWTADJ");
            var txtWtAdj = document.getElementById("ctl00_MyCPH1_txtWtAdj");
            var lblTotAdjAmt = document.getElementById("ctl00_MyCPH1_lblTotAdjAmt");
            var DDLWTADJ = document.getElementById("ctl00_MyCPH1_DDLWTADJ");
            if (txtWtAdj.value == "")
                txtWtAdj.value = "0";
            var rno = parseInt(GV.rows.length) + 1;
            var pref = "";
            var chkcount = 0;
            var totWT = 0.00;
            var totWTADJ = 0.00;
            for (var ij = 2; ij < rno; ij++) 
            {
                if (ij < 10)
                    pref = GV_frmname + "ctl0" + ij + "_";
                else
                    pref = GV_frmname + "ctl" + ij + "_";

                var chk = document.getElementById(pref + "chkDocket");
                var txtWt = document.getElementById(pref + "txtWt");
               
                if (chk.checked == true)
                    totWT = totWT + parseFloat(txtWt.value);
            }
            if (DDLWTADJ.value == "+") {
                totWTADJ = totWT + parseInt(txtWtAdj.value)
            }
            else if (DDLWTADJ.value == "-") {
                totWTADJ = totWT - parseInt(txtWtAdj.value)
            }
            lblTOTWT.innerText = totWT;
            HIDTOTWT.value = totWT;
            lblTotAdjAmt.innerText = totWTADJ;
        }

	    function ENABLED_ALLFIELDS(chkval) {
	        
	        var ctrlID=chkval.getAttribute('ID');
	        var arpkg = document.getElementById(ctrlID.replace("chkDocket", "txtPkgs"));
	        var arwt = document.getElementById(ctrlID.replace("chkDocket", "txtWt"));
	        
	        if (chkval.checked == true) {
	            arpkg.disabled = false;
	        }
	        else {
	            arpkg.disabled = true;
	            arwt.disabled = true;
	        }
	        calculateTotWeight();
	        return true;
	    }

	    function locTest(txtid, testtype) {
	        var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
	        var btnSubmit = document.getElementById("ctl00_MyCPH1_btnSubmit");
	        hdnajaxstate.value = "1";

	        //var hdnclient=document.getElementById("ctl00_MyCPH1_hdnclient");
	        var txt = document.getElementById(txtid);
	        if (txt.value == "") {
	            hdnajaxstate.value = "0";
	            return false;
	        }

	        txt.value = txt.value.toUpperCase();
	        var strpg = "";
	        var findobj = false;
	        findobj = GetXMLHttpObject();

	        if (findobj) {

	            strpg = "../AjaxResponse.aspx?mode=check&code1=" + testtype + "&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();

	            findobj.open("GET", strpg);
	            findobj.onreadystatechange = function() {
	                if ((findobj.readyState == 4) && (findobj.status == 200)) {
	                    var res = findobj.responseText.split("|");
	                    if (res[0] == "false") {
	                        if (testtype == "citytest")
	                            alert("City doesn't Exists...");
	                        else if (testtype == "loctest") {
	                            alert("Please enter valid Location code...");
	                        }
	                        else if (testtype == "zonetest")
	                            alert("Region doesn't Exists...");
	                        else if (testtype == "emptest") {
	                            alert("Employee doesn't Exists...");
	                        }
	                        txt.value = "";
	                        txt.focus();
	                        hdnajaxstate.value = "0";
	                        btnSubmit.disabled = true;
	                        return false;
	                    }
	                    else if (res[0] == "true") {
	                        hdnajaxstate.value = "0";
	                    }
	                }
	            }
	            findobj.send(null);
	        }

	        return true;
	    }

	    function openPopupLoc() {
	        window.open("popup_locations.aspx", null, "height=300,width=400,left=300,top=200,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no");
	    }
    </script>

    <asp:UpdatePanel ID="upTHCCreate" runat="server">
        <ContentTemplate>
            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="Table1"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="4" align="left">
                        <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
                        <font class="blackfnt"><b>Select criteria for preparing
                            <%=strDocumentMF%>
                        </b></font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" width="10%">
                        <font class="blackfnt">Manual MF #:</font>
                    </td>
                    <td align="left" width="40%">
                        <asp:TextBox ID="txtManualNo" CssClass="input" runat="server" Text="" MaxLength="25"
                            Width="200"></asp:TextBox>
                        <font class="bluefnt">NA <i>if not applicable</i></font>
                    </td>
                    <td align="left" width="10%">
                        <font class="blackfnt">MF Date:</font>
                    </td>
                    <td align="left" width="40%">
                        <asp:TextBox ID="txtDocumentDate" CssClass="input" runat="server" Text="" MaxLength="10"
                            Width="70"></asp:TextBox>
                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDocumentDate,'a','dd/MM/yyyy'); return false;"
                            id="a">
                            <img src="./../../images/calendar.jpg" border="0" />
                        </a>
                        <asp:Label ID="lblddmmyy1" runat="server" CssClass="bluefnt" Text=" [dd/mm/yyyy] " />
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Next Stop:</font></td>
                    <td align="left" colspan="3">
                        <asp:TextBox ID="txtNextStop" runat="server" CssClass="input" Text="" MaxLength="25"
                            Width="50" OnBlur="Javascript:return locTest(this.getAttribute('id'),'loctest');"></asp:TextBox>
                        <input type="button" value="..." runat="server"  class="blackfnt" BorderStyle="Groove" id="btnAt" onclick="openPopupLoc();" />
                        <div id="Dic_Desc" runat="server" class="boxbg" />
                        
                        <%--<atlas:AutoCompleteExtender runat="server" ID="nextloc" DropDownPanelID="Dic_Desc">
                            <atlas:AutoCompleteProperties TargetControlID="txtNextStop" ServicePath="../AtlasAutoComplete.asmx"
                                ServiceMethod="GetLocation" MinimumPrefixLength="1" Enabled="true" />
                        </atlas:AutoCompleteExtender>--%>
                        
                        <ajaxToolkit:AutoCompleteExtender ID="nextloc" runat="server" Enabled="True"
                        MinimumPrefixLength="1" ServiceMethod="GetLocation" CompletionListItemCssClass="autocomplete_listItem"
                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../AtlasAutoComplete.asmx"
                        TargetControlID="txtNextStop">
                    </ajaxToolkit:AutoCompleteExtender>
                        
                        <asp:Label ID="lblError1" runat="server" Text="Invalid Next Location" Visible="false"
                            CssClass="redfnt"></asp:Label>
                    </td>
                </tr>
            </table>
            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblDocketCreteria"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="2" style="text-align: left">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Select Docket Criteria"
                            Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" valign="Top">
                         <font class="blackfnt"><%=strDocumentDKT%>  Date  </font>
                    </td>
                    <td>
                        <Date:DT ID="DT" runat="server" />
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Transition Mode:</font>
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="cboTransMode" runat="server" EnableViewState="true" DataSourceID="MySQLDataSource_TransModes"
                            DataTextField="CodeDesc" DataValueField="CodeID">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Destination:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtDestination" runat="server" Text="" MaxLength="500" Width="300"></asp:TextBox>
                        <div id="Div_Dest" runat="server" class="boxbg" />
                        <%--<atlas:AutoCompleteExtender runat="server" ID="destcd" DropDownPanelID="Div_Dest">
                            <atlas:AutoCompleteProperties TargetControlID="txtDestination" ServicePath="../AtlasAutoComplete.asmx"
                                ServiceMethod="GetLocation" MinimumPrefixLength="1" Enabled="true" />
                        </atlas:AutoCompleteExtender>--%>
                        
                        <ajaxToolkit:AutoCompleteExtender ID="destcd" runat="server" Enabled="True"
                        MinimumPrefixLength="1" ServiceMethod="GetLocation" CompletionListItemCssClass="autocomplete_listItem"
                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../AtlasAutoComplete.asmx"
                        TargetControlID="txtDestination">
                    </ajaxToolkit:AutoCompleteExtender>
                        
                        <font class="bluefnt">[Seperated by <i>Comma</i> if multiple]</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Region:</font>
                    </td>
                    <td align="left">
                        <asp:ListBox Rows="4" SelectionMode="Multiple" ID="lstRegion" runat="server" Width="300"
                            DataSourceID="MySQLDataSource_Regions" DataTextField="LocName" DataValueField="LocCode">
                        </asp:ListBox>
                        <font class="bluefnt">Press Ctrl Key to Select/Deselect 1 or more rows</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">City From:</font>
                    </td>
                    <td align="left">
                        <%--                <asp:TextBox ID="txtCityFrom" runat="server" Text="" Width="70"></asp:TextBox>
--%>
                        <asp:DropDownList ID="cboCityFrom" runat="server" EnableViewState="true" DataSourceID="MySQLDataSource_Cities"
                            DataTextField="City" DataValueField="CityVal">
                        </asp:DropDownList>
                        &nbsp; <font class="blackfnt">To:</font> &nbsp;
                        <asp:DropDownList ID="cboCityTo" runat="server" EnableViewState="true" DataSourceID="MySQLDataSource_Cities"
                            DataTextField="City" DataValueField="CityVal">
                        </asp:DropDownList>
                        <%--                <asp:TextBox ID="txtCityTo" runat="server" Text="" Width="70"></asp:TextBox>
--%>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="center" colspan="2">
                        <font class="blackfnt"><b>- OR -</b></font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt"> <%=strDocumentDKT%> No(s).:</font>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDocketList" runat="server" Text="" Width="300"></asp:TextBox>
                        <font class="bluefnt">[Seperated by <i>Comma</i> if multiple]</font>
                    </td>
                </tr>
            </table>
            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblDocPreparedBy"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td align="left">
                        <font class="blackfnt"><b>Document Prepared By</b></font></td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <asp:TextBox CssClass="input" ID="txtPreparedBy" runat="server" MaxLength="15" Width="50"
                            OnBlur="Javascript:return locTest(this.getAttribute('id'),'emptest');"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <table border="0" cellspacing="1" cellpadding="3" width="900px" runat="server" id="trSubmit"
                visible="true">
                <tr>
                    <td align="left">
                        <asp:Button ID="btnSubmit" runat="server" Text="Show  <%=strDocumentDKT%> List >>" OnClick="ShowDocketsForMF"
                            OnClientClick="Javascript:return DATACHECK();" />
                    </td>
                </tr>
            </table>
            <table cellpadding="3" cellspacing="1" border="0" id="tblNoDocketsSelected" runat="server"
                width="900px" visible="false">
                <tr bgcolor="white">
                    <td align="left">
                        <font class="redfnt"><b>Alert: </b>No <%=strDocumentDKT%>  Were Selected</font>
                    </td>
                </tr>
            </table>
            <table cellpadding="3" cellspacing="1" border="0" class="boxbg" id="tblDocketList"
                runat="server" width="950px" visible="false">
                <tr style="background-color: White">
                    <td align="center">
                        <font class="blackfnt"><b> <%=strDocumentDKT%>  available for <%=strDocumentMF%> Generation</b></font>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <asp:GridView ID="dgDockets" runat="server" CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="dgHeaderStyle"
                            AllowSorting="true" AutoGenerateColumns="false" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                            Width="100%" DataKeyNames="DOCKNO,DOCKSF,PackagesLB,WeightLB">
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <input type="CheckBox" name="SelectAllCheckBox" onclick="SelectAll(this)">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkDocket" EnableViewState="true" Text="" Onclick="Javascript:return ENABLED_ALLFIELDS(this);" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="<%=strDocumentDKT%> #" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocketNo")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bkg. Date" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk4" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocketDate")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Trans. Mode" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnkTransMode" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "TransMode")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bkg. Loc." ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk3" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "OrgCode")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Dely. Loc." ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ReDestCode")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="City From-To" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnkFromTo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FromTo")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--                                <asp:TemplateField  HeaderText="Arrv. Date" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk6" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ArrivalDate")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>
--%>
                                <asp:TemplateField HeaderText="Comm. Dely Date" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk7" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Commited_DelyDate")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Pkgs.[L/B]" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hdpkgsno" Value='<%#DataBinder.Eval(Container.DataItem, "PackagesLB").ToString().Trim()%>'
                                            runat="server" />
                                        <asp:TextBox runat="server" Enabled="False" OnChange="Javascript:return ENABLED_WT(this);"
                                            ID="txtPkgs" Width="30" EnableViewState="true" Text='<%# DataBinder.Eval(Container.DataItem, "PackagesLB")%>' />
                                        <asp:Label ID="lnk8" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PackagesLB")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Wt.[L/B]" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hdwt" Value='<%#DataBinder.Eval(Container.DataItem, "WeightLB").ToString().Trim()%>'
                                            runat="server" />
                                        <asp:TextBox runat="server" OnChange="Javascript:return CHK_WT(this);" Enabled="False"
                                            ID="txtWt" Width="30" EnableViewState="true" Text='<%# DataBinder.Eval(Container.DataItem, "WeightLB")%>' />
                                        <asp:Label ID="lnk9" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "WeightLB")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr class="blackfnt">
                    <td id="wtsdj" runat="server" bgcolor="white" align="right">
                       Weight Adjustment:&nbsp;
                       <asp:Label ID="lblTOTWT" runat="server" Font-Bold="true" Text="0"></asp:Label>
                       <asp:HiddenField  runat="server" ID="HIDTOTWT" Value="0"/>
                        <asp:DropDownList ID="DDLWTADJ" CssClass="blackfnt" runat="server" onchange="calculateTotWeight();">
                            <asp:ListItem Text="+" Value="+"></asp:ListItem>
                            <asp:ListItem Text="-" Value="-"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtWtAdj" Style="text-align: right;" runat="server"
                            CssClass="input" Width="60" Text="0" MaxLength="10" onkeypress="validInt(event);" onchange="calculateTotWeight();">
                        </asp:TextBox>
                        <b>&nbsp;=&nbsp;</b>
                        <asp:Label ID="lblTotAdjAmt" runat="server" Font-Bold="true" Text="0"></asp:Label>
                    </td>
                </tr>
            </table>
            <table border="0" cellspacing="1" cellpadding="3" width="900px" runat="server" id="tblSubmitBtn"
                visible="false">
                <tr class="blackfnt">                     
                    <td align="center">
                        <asp:Button ID="btnPrepareManifest" OnClientClick="Javascript:return CHKREC();"  runat="server" Text="Prepare MF"
                            OnClick="PrepareManifest" />
                            <asp:Label runat="server" ID="lblError" CssClass="redfnt"></asp:Label>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
