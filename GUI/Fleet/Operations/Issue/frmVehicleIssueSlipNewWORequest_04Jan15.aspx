<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="frmVehicleIssueSlipNewWORequest.aspx.cs" Inherits="frmVehicleIssueSlipNewWORequest"
    EnableEventValidation="true" %>

<%@ Register Assembly="TimePicker" Namespace="MKB.TimePicker" TagPrefix="MKB" %>
<%@ Register TagPrefix="UC2" TagName="UCPaymentControl" Src="~/UserControls/PaymentControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


    <script language="javascript" type="text/javascript" src="../../../images/DateControl.js"></script>

    <script type="text/javascript" language="javascript" src="AJAX_Validator/NewTripGenerate.js?v1"></script>

    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"> </script>

    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript">
        //var cal = new CalendarPopup("Div1"); 
        //cal.setCssPrefix("TEST");
        //cal.showNavigationDropdowns();

        //function GetTabSet()
        //{
        //    frmVehicleIssueSlipNewWORequest.GetDataSet(BindDatatoTable_callback);
        //}
        //function BindDatatoTable_callback(responce)
        //{
        //    if(responce.error == null) 
        //    { 
        //        var ddlRoute = document.getElementById("ctl00_MyCPH1_ddlRoute");    
        //        var ds = responce.value;
        //        if(ds!= null && typeof(ds) == "object" && ds.Tables!=null)
        //        {
        //            for(i= ddlRoute.options.length-1; i>=0; i--)
        //            {
        //                ddlRoute.options.remove(i);
        //            }
        //            for(var i=0;i<ds.Tables[0].Rows.length;i++)
        //            {
        //                ddlRoute.options[ddlRoute.options.length] = new Option(ds.Tables[0].Rows[i].RUTDESC,ds.Tables[0].Rows[i].RUTCD);
        //            }
        //        } 
        //    } 
        // }

   
    </script>
    
    <script type="text/javascript">
    var styleToSelect;
    function onOk(){}
</script>

    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../../images/loading.gif" alt="" />
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
    <asp:UpdatePanel runat="server" UpdateMode="Always" ID="updatePanel8">
        <ContentTemplate>
            <asp:Table runat="server" CellSpacing="1" Width="800px">
                <asp:TableRow Style="background-color: white">
                    <asp:TableCell HorizontalAlign="left" Width="45%">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server" Text="Trip Sheet >> Issue New without Request" />
                    </asp:TableCell></asp:TableRow>
            </asp:Table>
            <hr size="1" color="#8ba0e5">
            <br />
            <asp:Table CellSpacing="1" CellPadding="3" runat="server" runat="server" class="boxbg"
                Width="800px" BorderWidth="0">
                <asp:TableRow Style="background-color: white">
                    <asp:TableCell HorizontalAlign="left">
                        <%--  <asp:Table cellspacing="1" cellpadding="3" width="800px"  class="boxbg" border="0">
            
            <asp:TableRow style="background-color: white" HorizontalAlign="right">
                <asp:TableCell ColumnSpan="4" HorizontalAlign="right" >--%>
                        <font class="blackfnt" color="red">'*'</font> <font class="blackfnt">indicates compulsory
                            fields.</font>
                        <%--  </asp:TableCell>
            </asp:TableRow>    
      </asp:Table>    --%>
                        <br />
                        <asp:Table runat="server" CellSpacing="1" CellPadding="3" Width="900px" class="boxbg"
                            border="0">
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell ColumnSpan="4" HorizontalAlign="center">
                                    <asp:Label ID="lblError" runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                                    <asp:Label ID="lblDataError" runat="server" ForeColor="red" CssClass="blackfnt"></asp:Label>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow class="bgbluegrey">
                                <asp:TableCell ColumnSpan="4" HorizontalAlign="center">
                                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="NEW TRIP SHEET FORM"></asp:Label></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left">
                  <font class="bluefnt">Trip Sheet Id</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                   <font class=blackfnt color="red">< System generated ></font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <font class="blackfnt" color="red">*</font> <font class="bluefnt">Trip Sheet Date</font>
                                    <asp:HiddenField ID="hfFinancialYr" runat="server" />
                                    <asp:HiddenField ID="hfAutoManualTsStatus" runat="server" />
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:TextBox ID="txtDate" runat="server" 
                                                    BorderStyle="Groove" CssClass="input" MaxLength="10" Width="60px"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtDate"
                                                    runat="server" />
                                            </td>
                                            <td>
                                                <MKB:TimeSelector ID="TimeSelector1" runat="server" DisplaySeconds="false" CssClass="input">
                                                </MKB:TimeSelector>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white" runat="server" ID="row_Auto_Manual_TSNo">
                                <asp:TableCell HorizontalAlign="left">
                  <font class="blackfnt" color="red">*</font> <font class=bluefnt>Manual Trip Sheet No.</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                   <font class=blackfnt color="red">< System generated ></font>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white" runat="server" ID="row_Manual_TSNo">
                                <asp:TableCell HorizontalAlign="left">
                  <font class="blackfnt" color="red">*</font> <font class=bluefnt>Manual Trip Sheet No.</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                                    <font class="blackfnt">
                                        <asp:TextBox ID="txtManualTripSheetNo" runat="server" BorderStyle="Groove" Width="100"
                                            MaxLength="50" CssClass="input" /><%--OnTextChanged="Check_ManualTripSheetNo"  AutoPostBack=true--%>
                                        <asp:RequiredFieldValidator ID="ReqManualTripSheetNo" ControlToValidate="txtManualTripSheetNo"
                                            runat="server" Display="Dynamic" Text="!" ValidationGroup="main"></asp:RequiredFieldValidator>
                                        <asp:Label ID="lbl_Manual_TS_Err" runat="server" CssClass="balckfnt" ForeColor="Red"></asp:Label><asp:UpdatePanel
                                            ID="UpdatePanel2" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:Label ID="lblMTS" runat="server" CssClass="balckfnt" ForeColor="red"></asp:Label>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="txtManualTripSheetNo" EventName="TextChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </font>
                                </asp:TableCell>
                            </asp:TableRow>
                            <%--  </asp:Table>--%>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left">
                  <font class="bluefnt">Start Location</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <font class="bluefnt">
                                        <asp:TextBox ID="txtStartLoc" runat="server" BorderStyle="None" Width="50" MaxLength="5"
                                            ReadOnly="true"></asp:TextBox>
                                        <asp:HiddenField ID="hfTodayDate" Value="" runat="server" />
                                    </font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                  <font class="blackfnt" color="red">*</font> <font class="bluefnt">End Location</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <font class="bluefnt">
                                        <asp:TextBox ID="txtEndLoc" runat="server" BorderStyle="Groove" Width="50" MaxLength="5"
                                            CssClass="input" OnTextChanged="CheckLocation" AutoPostBack="true"></asp:TextBox>
                                        <input id="btnPopupLoc" type="button" value="..." name="custpup12" runat="server" />
                                        <asp:UpdatePanel ID="UpdatePanelEndLoc" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:Label ID="LblLocError" runat="server" CssClass="balckfnt" ForeColor="red"></asp:Label>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="txtEndLoc" EventName="TextChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                        <asp:RequiredFieldValidator ID="ReqEndLoc" runat="server" Display="Dynamic" Text="!"
                                            ControlToValidate="txtEndLoc" ValidationGroup="main"></asp:RequiredFieldValidator>
                                    </font>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left"> <font class="blackfnt" color="red">*</font>
                  <font class="bluefnt">Category</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="blackfnt" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                                        <asp:ListItem Selected="True" Value="">Select</asp:ListItem>
                                        <asp:ListItem Value="External Usage">External Usage</asp:ListItem>
                                        <asp:ListItem Value="Internal Usage">Internal Usage</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="Reqcategory" runat="server" Display="Dynamic" Text="!"
                                        ControlToValidate="ddlCategory" ValidationGroup="main"></asp:RequiredFieldValidator>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:UpdatePanel ID="upCurrLocationCode1" runat="server">
                                        <ContentTemplate>
                                            <asp:Label ID="lblCutcode" runat="server" Text="Enter Customer Code" Visible="false"
                                                CssClass="bluefnt" />
                                            <asp:Label ID="lblMarket_own" runat="server" Text="Market\Own" Visible="false" CssClass="bluefnt" /><br />
                                            <hr runat="server" id="hr1" color="#8ba0e5" size="0.1px" visible="false" />
                                            <asp:Label ID="lblExternalUsages" runat="server" Text="External Usages Category"
                                                Visible="false" CssClass="bluefnt" />
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="ddlMarket" runat="server" Visible="false">
                                                <asp:ListItem Selected="True">Own</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:TextBox ID="txtCustCode" runat="server" Width="100px" Visible="false" CssClass="input"
                                                MaxLength="50"></asp:TextBox>&nbsp;
                                            <asp:Label ID="lblPopup" Visible="false" runat="server" BorderStyle="Groove" TabIndex="18"
                                                Height="10px" Text='<a href="javascript:nwOpen(1)">...</a>' Width="14px"></asp:Label>
                                            <asp:RequiredFieldValidator ID="ReqCustCode" runat="server" Display="Dynamic" Text="!"
                                                ControlToValidate="txtCustCode" ValidationGroup="main"></asp:RequiredFieldValidator>
                                            <asp:Label ID="lblErrorLocation1" class="blackfnt" ForeColor="red" runat="server"
                                                Tet="" />
                                            <br />
                                            <hr runat="server" id="hr2" color="#8ba0e5" size="0.1px" visible="false" />
                                            <asp:DropDownList ID="ddl_ExternalUsages_Category" Visible="false" runat="server" />
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="txtCustCode" EventName="TextChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="row_Vehicle_Mode" Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left">
              <font class="bluefnt">Select Vehicle Mode</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                                    <asp:HiddenField ID="hfDocketLabel" runat="server" />
                                    <font class="blackfnt">
                                        <asp:DropDownList ID="ddl_Vehicle_Mode" OnSelectedIndexChanged="ddl_Vehicle_Mode_SelectedIndexChanged"
                                            AutoPostBack="true" runat="server">
                                        </asp:DropDownList>
                                    </font>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="row_Vehicle_Name" Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left">
                                      <font class="blackfnt" color="red">*</font> <font class="bluefnt">Enter Vehicle</font>
                                </asp:TableCell>
                                <asp:TableCell ColumnSpan="3">
                                    <asp:TextBox ID="tb_Vehicle_Name" MaxLength="25" CssClass="input" runat="server"
                                        BorderStyle="Groove"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="row_Vehicle_Manual" Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left">
              <font class="blackfnt" color=red>*</font> 
              <font class="bluefnt">Enter Vehicle No.</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                                    <font class="blackfnt">
                                        <asp:HiddenField ID="hf_Vehicle_Filter" runat="server" Value="" />
                                        <%--AutoPostBack="true" OnTextChanged="txtVehNo_TextChanged" --%>
                                        <asp:TextBox ID="txtVehNo" CssClass="input" runat="server" BorderStyle="Groove"></asp:TextBox>
                                        <asp:Label ID="lblVeh" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:PopUpVehNo(1)">...</a>'
                                            Width="14px"></asp:Label>
                                        <asp:Label ID="lblVehCheck" runat="server" CssClass="redfnt"></asp:Label>
                                        <asp:RequiredFieldValidator ID="ReqVehno" runat="server" Display="Dynamic" Text="!"
                                            ControlToValidate="txtVehNo" ValidationGroup="main"></asp:RequiredFieldValidator>
                                    </font>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="row_Vehicle_Select" Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left">
                                    <font class="blackfnt" color=red>*</font> <font class=bluefnt>Select Vehicle No.</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                                    <font class="blackfnt">
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" RenderMode="Inline" UpdateMode="always">
                                            <ContentTemplate>
                                                <asp:DropDownList ID="cboVehno" AutoPostBack="true" runat="server" OnSelectedIndexChanged="cboVehno_SelectedIndexChanged">
                                                </asp:DropDownList>
                                                <asp:HiddenField ID="hdStatKm" runat="server" />
                                                <asp:RequiredFieldValidator ID="rfv_cboVehno" runat="server" Display="Dynamic" Text="!"
                                                    ControlToValidate="cboVehno" ValidationGroup="main"></asp:RequiredFieldValidator>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </font>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="row_Driver_Name" Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left">
                                      <font class="blackfnt" color="red">*</font> <font class="bluefnt">Enter Driver1</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:TextBox ID="tb_Driver_Name1" CssClass="input" BorderStyle="Groove" runat="server" />
                                    <ajaxToolkit:AutoCompleteExtender runat="server" BehaviorID="AutoCompleteEx" ID="autoComplete1"
                                        TargetControlID="tb_Driver_Name1" ServicePath="~/services/FleetAutoComplet.asmx"
                                        ServiceMethod="GetAttachedDriver" MinimumPrefixLength="1" CompletionInterval="1000"
                                        EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement"
                                        CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                        DelimiterCharacters=";, :">
                                        <Animations>
                            <OnShow>
                                <Sequence>
                                    <%-- Make the completion list transparent and then show it --%>
                                    <OpacityAction Opacity="0" />
                                    <HideAction Visible="true" />
                                    
                                    <%--Cache the original size of the completion list the first time
                                        the animation is played and then set it to zero --%>
                                    <ScriptAction Script="
                                        // Cache the size and setup the initial size
                                        var behavior = $find('AutoCompleteEx');
                                        if (!behavior._height) {
                                            var target = behavior.get_completionList();
                                            behavior._height = target.offsetHeight - 2;
                                            target.style.height = '0px';
                                        }" />
                                    
                                    <%-- Expand from 0px to the appropriate size while fading in --%>
                                    <Parallel Duration=".4">
                                        <FadeIn />
                                        <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx')._height" />
                                    </Parallel>
                                </Sequence>
                            </OnShow>
                            <OnHide>
                                <%-- Collapse down to 0px and fade out --%>
                                <Parallel Duration=".4">
                                    <FadeOut />
                                    <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx')._height" EndValue="0" />
                                </Parallel>
                            </OnHide>
                                        </Animations>
                                    </ajaxToolkit:AutoCompleteExtender>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
               <font class=bluefnt>Enter Driver2</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:TextBox ID="tb_Driver_Name2" CssClass="input" BorderStyle="Groove" runat="server" />
                                    <ajaxToolkit:AutoCompleteExtender runat="server" BehaviorID="AutoCompleteEx1" ID="AutoCompleteExtender1"
                                        TargetControlID="tb_Driver_Name2" ServicePath="~/services/FleetAutoComplet.asmx"
                                        ServiceMethod="GetAttachedDriver" MinimumPrefixLength="1" CompletionInterval="1000"
                                        EnableCaching="true" CompletionSetCount="20" CompletionListCssClass="autocomplete_completionListElement"
                                        CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                        DelimiterCharacters=";, :">
                                        <Animations>
                            <OnShow>
                                <Sequence>
                                    <%-- Make the completion list transparent and then show it --%>
                                    <OpacityAction Opacity="0" />
                                    <HideAction Visible="true" />
                                    
                                    <%--Cache the original size of the completion list the first time
                                        the animation is played and then set it to zero --%>
                                    <ScriptAction Script="
                                        // Cache the size and setup the initial size
                                        var behavior = $find('AutoCompleteEx1');
                                        if (!behavior._height) {
                                            var target = behavior.get_completionList();
                                            behavior._height = target.offsetHeight - 2;
                                            target.style.height = '0px';
                                        }" />
                                    
                                    <%-- Expand from 0px to the appropriate size while fading in --%>
                                    <Parallel Duration=".4">
                                        <FadeIn />
                                        <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx1')._height" />
                                    </Parallel>
                                </Sequence>
                            </OnShow>
                            <OnHide>
                                <%-- Collapse down to 0px and fade out --%>
                                <Parallel Duration=".4">
                                    <FadeOut />
                                    <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx1')._height" EndValue="0" />
                                </Parallel>
                            </OnHide>
                                        </Animations>
                                    </ajaxToolkit:AutoCompleteExtender>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="row_Driver_Select" Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left">
                  <font class="blackfnt" color="red">*</font> <font class="bluefnt">Select Driver1</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <font class="blackfnt">
                                        <asp:UpdatePanel ID="UpdatePanel41" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                            <ContentTemplate>
                                                <asp:HiddenField ID="hf_Manual_Driver_Code" runat="server" />
                                                <asp:HiddenField ID="hfDriver_Photo" runat="server" />
                                                <asp:HiddenField ID="hfDriver_photo_Rule" runat="server" />
                                                <asp:HiddenField ID="hfDriverLic_Validity" runat="server" />
                                                <asp:HiddenField ID="hfDriverLic_Validity_Rule" runat="server" />
                                                <asp:HiddenField ID="hfDriver_TripCount" runat="server" />
                                                <asp:HiddenField ID="hfDriver_TripCount_Rule" runat="server" />
                                                <asp:HiddenField ID="hfTot_No_Trip" runat="server" />
                                                <asp:DropDownList ID="ddl_Driver1" runat="server" />
                                                <asp:RequiredFieldValidator ID="rfv_ddl_Driver1" runat="server" Display="Dynamic"
                                                    Text="!" ControlToValidate="ddl_Driver1" ValidationGroup="main"></asp:RequiredFieldValidator>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="cboVehno" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
               <font class=bluefnt>Select Driver2</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <font>
                                        <asp:DropDownList ID="ddl_Driver2" runat="server" />
                                    </font>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white" runat="server" ID="row_Driver_Manual">
                                <asp:TableCell HorizontalAlign="left">
                  <font class="blackfnt" color=red>*</font> <font class=bluefnt>Enter Driver1 Manual Code</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:TextBox ID="txtDriver1" onBlur="CheckDriver1ManualCode();" CssClass="input"
                                        BorderStyle="Groove" runat="server" />
                                    <%--OnTextChanged="RetrieveDriverDataInfo1"  AutoPostBack="true" --%>
                                    <asp:HiddenField ID="hfDriver1ID" runat="Server" Value="" />
                                    <asp:Label ID="Label4" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:PopUpDriver1(1)">...</a>'
                                        Width="14px"></asp:Label>
                                    <a href="javascript:ViewPhoto('ctl00_MyCPH1_txtDriver1')"><u>View Photo</u></a>
                                    <asp:Label ID="lblD1Error" runat="server" Text="" CssClass="redfnt"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
            <font class="bluefnt">Enter Driver2 Manual Code</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:TextBox ID="txtDriver2" onBlur="CheckDriver2ManualCode();" CssClass="input"
                                        BorderStyle="Groove" runat="server" />
                                    <%--AutoPostBack="true"  OnTextChanged="RetrieveDriverDataInfo2--%>"
                                    <asp:HiddenField ID="hfDriver2ID" runat="Server" Value="" />
                                    <asp:Label ID="Label5" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:PopUpDriver2(1)">...</a>'
                                        Width="14px"></asp:Label>
                                    <a href="javascript:ViewPhoto('ctl00_MyCPH1_txtDriver2')"><u>View Photo</u></a>
                                    <asp:Label ID="lblD2Error" Text="" runat="server" CssClass="redfnt"></asp:Label>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="row_Driver_Name_Dis" Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left">
                  <font class=bluefnt>Driver1 Name</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <font class="blackfnt">
                                        <asp:TextBox ID="LblDriver1Name" BorderStyle="none" runat="server"></asp:TextBox>
                                    </font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                  <font class=bluefnt>Driver2 Name</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <font class="blackfnt">
                                        <asp:TextBox ID="LblDriver2Name" BorderStyle="none" runat="server"></asp:TextBox>
                                    </font>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="row_Driver_License_Dis" Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left">
                  <font class="bluefnt">Driver1 License No.</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <font class="blackfnt">
                                        <asp:TextBox ID="lblLicno" BorderStyle="none" runat="server"></asp:TextBox>
                                    </font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                  <font class=bluefnt>Driver2 License No.</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <font class="blackfnt">
                                        <asp:TextBox ID="lblLicnoD2" BorderStyle="none" runat="server"></asp:TextBox>
                                    </font>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="row_Driver_LicenseValid_Dis" Style="background-color: White">
                                <asp:TableCell HorizontalAlign="left">
                  <font class="bluefnt">Driver1  License Valid upto</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <font class="blackfnt">
                                        <asp:TextBox ID="lblValidDt" BorderStyle="None" runat="server"></asp:TextBox>
                                    </font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                  <font class=bluefnt>Driver2 License Valid upto</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <font class="blackfnt">
                                        <asp:TextBox ID="lblValidDtD2" BorderStyle="None" runat="server"></asp:TextBox>
                                    </font>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left">
                  <font class="blackfnt" color=red>*</font> <font class=bluefnt>Starting Km. Reading</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                                    <asp:UpdatePanel ID="UpdatePanel10" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <font class="blackfnt">
                                                <asp:TextBox ID="txtStartKM" runat="server" BorderStyle="Groove" Width="100" MaxLength="6"
                                                    CssClass="input"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqStartKM" runat="server" Display="Dynamic" Text="!"
                                                    ControlToValidate="txtStartKM" ValidationGroup="main"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegStartKM" runat="server" ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                    SetFocusOnError="true" ControlToValidate="txtStartKM" Display="Dynamic"></asp:RegularExpressionValidator>
                                            </font>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="cboVehno" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </asp:TableCell>
                                <%--                <asp:TableCell HorizontalAlign="left" >
                  <font class="blackfnt" color=red>*</font> <font class=bluefnt>Fuel Filled Ltrs.</font>
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left">
                   <font class=blackfnt >
                   <asp:TextBox ID="txtFuel" runat="server" BorderStyle="Groove" Width="100" MaxLength="6" CssClass="input" ></asp:TextBox>
                     <asp:RequiredFieldValidator ID="ReqFuel" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtFuel" ValidationGroup="main"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegFuel" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtFuel" Display="Dynamic"></asp:RegularExpressionValidator>

                   
                    </font>
                </asp:TableCell>--%>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="row_Trip_Route_B" Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left"><font class="bluefnt">Route</font></asp:TableCell>
                                <asp:TableCell ColumnSpan="3">
                                    <asp:DropDownList ID="ddlRouteDetails" runat="server">
                                        <%-- OnSelectedIndexChanged="ddlRouteDetails_SelectedIndexChanged" AutoPostBack="true"  --%>
                                        <%--<asp:ListItem Text="Both" Value="0"></asp:ListItem>  --%>
                                        <asp:ListItem Text="Route Wise" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="City Wise" Selected="True" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="row_Trip_Route_C" Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left">
                                <font class="bluefnt">From City</font>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:HiddenField ID="hfLOCAL_CITY" runat="server" />
                                    <asp:TextBox ID="txtFromCity" BorderStyle="Groove" runat="server" Width="100px" CssClass="input" />
                                    <asp:Label ID="Label1" Visible="true" runat="server" BorderStyle="Groove" TabIndex="18"
                                        Text='<a href="javascript:nwOpenCity(1)">...</a>' Width="14px"></asp:Label>
                                    <asp:Label ID="lbl_FromCity_Err" CssClass="blackfnt" runat="server" ForeColor="red"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                <font class="bluefnt">To City</font>
                                </asp:TableCell>
                                <asp:TableCell>
                                    <asp:TextBox ID="txtToCity" BorderStyle="Groove" runat="server" Width="100px" CssClass="input" />
                                    <asp:Label ID="Label2" Visible="true" runat="server" BorderStyle="Groove" TabIndex="18"
                                        Text='<a href="javascript:nwOpenCity(2)">...</a>' Width="14px"></asp:Label>
                                    <asp:Label ID="lbl_ToCity_Err" CssClass="blackfnt" runat="server" ForeColor="red"></asp:Label>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="row_Trip_Route_R" Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left">
                                    <font class="blackfnt" color="red">*</font>
                                    <asp:Label ID="Label3" class="bluefnt" runat="server" Text="Select Trip Route :"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left" ColumnSpan="3">
                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <asp:DropDownList ID="ddlRoute" runat="server" Width="343px">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                        <Triggers>
                                            <%--<asp:AsyncPostBackTrigger ControlID="cboVehno" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="txtVehNo" EventName="TextChanged" /> --%>
                                            <asp:AsyncPostBackTrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="row_THC_Attached" Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left"> 
                  <font class="bluefnt">THC Attached</font>
                                </asp:TableCell>
                                <asp:TableCell ColumnSpan="3" HorizontalAlign="left">
                                    <asp:CheckBox ID="chkTHCAttached" runat="server" />
                                    <asp:HiddenField ID="hfAttached" runat="server" Value="" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="TableRow1" Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left"> <%--<font class="blackfnt" color="red">*</font>--%>
                            <font class="bluefnt">Transit Time</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:TextBox Style="text-align: right" ID="tb_Trasit_HH" MaxLength="3" onblur="checkDecimal(this.getAttribute('id'), 'TRUE')"
                                        BorderStyle="Groove" CssClass="input" onkeypress="javascript:return validInt(event);"
                                        runat="server" Width="20px"></asp:TextBox>&nbsp; :
                                    <asp:TextBox Style="text-align: right" ID="tb_Trasit_MM" MaxLength="2" onblur="checkDecimal(this.getAttribute('id'), 'TRUE');CheckValidMin(this.getAttribute('id'), 'TRUE')"
                                        CssClass="input" BorderStyle="Groove" onkeypress="javascript:return validInt(event);"
                                        runat="server" Width="20px" />&nbsp;(HH : MM)
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left"> 
                            <font class="bluefnt">Driver Balance</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:UpdatePanel ID="UpdatePanel9" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                                        <ContentTemplate>
                                            <%-- <asp:Label ID="LblDriverBalance" runat="server" Text=""></asp:Label>--%>
                                            <asp:TextBox ID="LblDriverBalance" BorderStyle="None" onfocus="this.blur();" runat="server"></asp:TextBox>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlCategory" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="Row_Checklist" Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left"> 
                  <font class="bluefnt">Checklist</font>
                                </asp:TableCell>
                                <asp:TableCell ColumnSpan="3" HorizontalAlign="left">
                                    <div class="demoarea">
                                        <asp:LinkButton ID="lnkCheckList" runat="server" Text="Click here for CheckList" />
                                        <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender" runat="server" TargetControlID="lnkCheckList"
                                            PopupControlID="Panel6" BackgroundCssClass="modalBackground" OkControlID="OkButton"
                                            OnOkScript="onOk()" DropShadow="true" PopupDragHandleControlID="Panel3" />
                                    </div>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="row_UFL1" Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left"> <font class="blackfnt" color="red">*</font>
                            <font class="bluefnt">Per Trip Revenue Captute</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:TextBox Style="direction: rtl" BorderStyle="Groove" MaxLength="10" onkeypress="InputNumericValuesOnly()"
                                        CssClass="input" ID="tb_Trip_Revenue" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfv_tb_Trip_Revenue" runat="server" Display="Dynamic"
                                        Text="!!" ControlToValidate="tb_Trip_Revenue" ValidationGroup="main"></asp:RequiredFieldValidator>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left"> <font class="blackfnt" color="red">*</font>
                            <font class="bluefnt">UFL Weight</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:TextBox Style="direction: rtl" Width="60px" BorderStyle="Groove" MaxLength="10"
                                        onkeypress="InputNumericValuesOnly()" Text="0.00" onblur="CountTotalUFL()" CssClass="input"
                                        ID="tb_UFL_Weight" runat="server"></asp:TextBox>&nbsp;(in Ton)
                                    <asp:RequiredFieldValidator ID="rfv_tb_UFL_Weight" runat="server" Display="Dynamic"
                                        Text="!!" ControlToValidate="tb_UFL_Weight" ValidationGroup="main"></asp:RequiredFieldValidator>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="row_UFL2" Style="background-color: white">
                                <asp:TableCell HorizontalAlign="left"> <font class="blackfnt" color="red">*</font>
                            <font class="bluefnt">AFL Weight</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:TextBox Style="direction: rtl" Width="60px" BorderStyle="Groove" MaxLength="10"
                                        onkeypress="InputNumericValuesOnly()" onblur="CountTotalUFL()" Text="0.00" CssClass="input"
                                        ID="tb_AFL_Weight" runat="server"></asp:TextBox>&nbsp;(in Ton)
                                    <asp:RequiredFieldValidator ID="rfv_tb_AFL_Weight" runat="server" Display="Dynamic"
                                        Text="!!" ControlToValidate="tb_AFL_Weight" ValidationGroup="main"></asp:RequiredFieldValidator>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left"> <font class="blackfnt" color="red">*</font>
                            <font class="bluefnt">Total Weight</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:TextBox Style="direction: rtl" Width="60px" BorderStyle="None" MaxLength="10"
                                        onkeypress="InputNumericValuesOnly()" Text="0.00" ID="tb_Total_Weight" runat="server"></asp:TextBox>&nbsp;(in
                                    Ton)
                                    <asp:RequiredFieldValidator ID="rfv_tb_Total_Weight" runat="server" Display="Dynamic"
                                        Text="!!" ControlToValidate="tb_Total_Weight" ValidationGroup="main"></asp:RequiredFieldValidator>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="row_Docket_btn" class="bgbluegrey">
                                <asp:TableCell ColumnSpan="4" HorizontalAlign="right">
                                    <asp:Button ID="btnAttachDocket" runat="server" OnClick="btnAttachDocket_Click" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="row_Docket_hdr" class="bgbluegrey">
                                <asp:TableCell ColumnSpan="3" HorizontalAlign="left">
                                    <asp:Label ID="lblDocketLable" runat="server" CssClass="blackfnt" Font-Bold="true" />
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:CheckBox ID="chkSelAllDocket" Text="Select All" runat="server" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow runat="server" ID="row_Dockets" Style="background-color: white">
                                <asp:TableCell ColumnSpan="4" HorizontalAlign="left">
                                    <asp:Panel ID="Panel3" Height="200px" ScrollBars="Vertical" runat="server">
                                        <asp:CheckBoxList ID="chklstDockets" runat="server" RepeatColumns="6" Font-Names="Verdana"
                                            Font-Size="8pt" Width="98%">
                                        </asp:CheckBoxList>
                                    </asp:Panel>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <br />
                        <asp:Table ID="tbl_Driver_Adv" runat="server" CellSpacing="1" CellPadding="3" Style="width: 900px"
                            class="boxbg" border="0">
                            <asp:TableRow class="bgbluegrey">
                                <asp:TableCell ColumnSpan="4" HorizontalAlign="center"><font class=blackfnt><b>Details of Advance Taken</b></font></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow Style="background-color: white">
                                <asp:TableCell ColumnSpan="4" HorizontalAlign="left">
                                    <asp:Table border="0" Width="75%">
                                        <asp:TableRow>
                                            <asp:TableCell>
                                                <asp:Label ID="lbl_dgAdvanceDet_Err" CssClass="redfnt" runat="server" Text=""></asp:Label>
                                                <asp:DataGrid ID="dgAdvanceDet" runat="server" AutoGenerateColumns="False" CellPadding="2"
                                                    CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                    BorderWidth="3px" Width="100%">
                                                    <Columns>
                                                        <asp:TemplateColumn HeaderText="Sr.No.">
                                                            <ItemTemplate>
                                                                <center>
                                                                    <%# Container.ItemIndex+1 %>.
                                                                    <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                                </center>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn HeaderText="Place">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtAdvPlace" CssClass="input" runat="server" Width="150px" BorderStyle="Groove"
                                                                    MaxLength="50"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn HeaderText="Advance Date (dd/mm/yyyy)">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtAdvDt" CssClass="input" onblur="CheckAdvDt()" runat="server"
                                                                    MaxLength="10" Width="65" BorderStyle="Groove"></asp:TextBox>
                                                                <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtAdvDt"
                                                                    runat="server" />
                                                                <asp:RegularExpressionValidator ID="REVAdvDt" runat="server" ControlToValidate="txtAdvDt"
                                                                    ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                                                    Width="1px"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn HeaderText="Amount">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtAdvAmt" CssClass="input" onblur="FillPaymentAmt()" runat="server"
                                                                    Width="60px" BorderStyle="Groove" MaxLength="6"></asp:TextBox>
                                                                <%--OnTextChanged="PopulateAdvamt"  AutoPostBack="true"--%>
                                                                <asp:RegularExpressionValidator ID="RegAdvAmt" runat="server" ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                                    SetFocusOnError="true" ControlToValidate="txtAdvAmt" Display="Dynamic"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn HeaderText="Branch Code">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtBranchCode" CssClass="input" runat="server" onBlur="CheckValidBranchCode(this)"
                                                                    Width="100px" BorderStyle="Groove" MaxLength="15"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        <asp:TemplateColumn HeaderText="Advance Paid By">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtSignature" CssClass="input" runat="server" Width="100px" BorderStyle="Groove"
                                                                    MaxLength="50"></asp:TextBox>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                    </Columns>
                                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle ForeColor="#000066" />
                                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey" Font-Italic="False"
                                                        Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                </asp:DataGrid>
                                                <br />
                                                <asp:HiddenField ID="hfPaymentAmount" runat="server" />
                                                <asp:UpdatePanel ID="UpdatePanelpayment" runat="server">
                                                    <ContentTemplate>
                                                        <UC2:UCPaymentControl ID="UCPayment" runat="server"></UC2:UCPaymentControl>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                                <br />
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell></asp:TableRow>
                <asp:TableRow class="bgbluegrey">
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" ValidationGroup="main"
                            OnClick="SubmitData" />
                    </asp:TableCell></asp:TableRow>
            </asp:Table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:Panel ID="Panel6" runat="server" Style="display: none" CssClass="modalPopup"
        Height="280px" Width="600px">
        <table>
            <tr>
                <td>
                    <asp:Panel ID="Panel4" runat="server" Style="cursor: move; text-align: center; background-color: #DDDDDD;
                        border: solid 1px Gray; color: Black" Height="20px" Width="600">
                        <div>
                            <p>
                                CheckList
                            </p>
                        </div>
                    </asp:Panel>
                </td>
            </tr>
            <tr style="background-color: white">
                <td class="blackfnt" colspan="3" style="text-align: Center">
                    <asp:Label ID="lblCheckListError" runat="server" CssClass="redfnt" Font-Bold="true"></asp:Label>
                    <asp:HiddenField ID="hfChecklist_Mandatory" runat="server" />
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" style="text-align: right">
                    <asp:Panel ID="Panel5" runat="server" Height="230px" Width="600px" HorizontalAlign="Left"
                        ScrollBars="Vertical">
                        <asp:GridView ID="gvChecklist" runat="server" CellPadding="2" CellSpacing="1" AutoGenerateColumns="False"
                            SelectedIndex="1" ShowFooter="false" Width="550px" BorderStyle="None" EmptyDataText="No Records Found..."
                            BorderWidth="3px" CssClass="blackfnt" HeaderStyle-CssClass="GridHeader" Visible="false">
                            <Columns>
                                <asp:BoundField DataField="Category" HeaderText="Category">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="True" Font-Bold="True" Width="100px" />
                                    <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CheckList" HeaderText="Checklist">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="True" Font-Bold="True" Width="250px" />
                                    <ItemStyle Width="250px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Checking Done">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="True" Font-Bold="True" Width="100px" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect" runat="server" Checked="false" />
                                    </ItemTemplate>
                                    <ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle" CssClass="bgwhite" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Comments">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="True" Font-Bold="True" Width="100px" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtComments" CssClass="input" Width="100px" Style="text-align: left"
                                            runat="server" BorderStyle="Groove"></asp:TextBox>
                                        <asp:HiddenField ID="Category_ID" runat="Server" Value='<%# DataBinder.Eval(Container.DataItem, "Chk_Cat") %>' />
                                        <asp:HiddenField ID="CheckList_ID" runat="Server" Value='<%# DataBinder.Eval(Container.DataItem, "Chk_ID") %>' />
                                    </ItemTemplate>
                                    <ItemStyle Width="150px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                                </asp:TemplateField>
                                <%-- <asp:BoundField DataField="Chk_Cat" HeaderText="Category ID" Visible="false">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" Font-Bold="True" Width="100px" />
                                <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Chk_ID" HeaderText="CheckList ID" Visible="false">
                                <HeaderStyle HorizontalAlign="Center" Wrap="True" Font-Bold="True" Width="100px" />
                                <ItemStyle Width="100px" HorizontalAlign="Left" VerticalAlign="Middle" CssClass="bgwhite" />
                            </asp:BoundField>--%>
                            </Columns>
                            <HeaderStyle ForeColor="Black" Font-Bold="False" Font-Italic="False" Font-Size="8pt"
                                CssClass="bgbluegrey" />
                        </asp:GridView>
                        <asp:Table ID="Table2" runat="server" Visible="false" CellSpacing="1" CellPadding="3"
                            Width="550px" class="boxbg" border="0">
                            <asp:TableRow class="bgbluegrey">
                                <asp:TableCell HorizontalAlign="left">
                                    <font class="bluefnt">Checked By</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:TextBox ID="txtCheckedBy" CssClass="input" Width="100px" Style="text-align: left"
                                        runat="server" BorderStyle="Groove"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <font class="bluefnt">Checked Date</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:TextBox ID="txtCheckedDate" CssClass="input" Width="100px" Style="text-align: left"
                                        runat="server" BorderStyle="Groove"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" TargetControlID="txtCheckedDate"
                                        runat="server" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow class="bgbluegrey">
                                <asp:TableCell HorizontalAlign="left">
                                    <font class="bluefnt">Approved By</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:TextBox ID="txtApprovedBy" CssClass="input" Width="100px" Style="text-align: left"
                                        runat="server" BorderStyle="Groove"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <font class="bluefnt">Approved Date</font>
                                </asp:TableCell>
                                <asp:TableCell HorizontalAlign="left">
                                    <asp:TextBox ID="txtApprovedDate" CssClass="input" Width="100px" Style="text-align: left"
                                        runat="server" BorderStyle="Groove"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" TargetControlID="txtApprovedDate"
                                        runat="server" />
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="OkButton" runat="server" Width="100px" Text="OK" />
                </td>
            </tr>
        </table>
        </div>
    </asp:Panel>
</asp:Content>
