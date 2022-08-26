<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="SalesSummary.aspx.cs"  Inherits="_Default" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="JavaScript" SRC="./../../Images/CalendarPopup.js"></script> 
<script language="javascript" src="./../../images/commonJs.js"></script>
<script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
</script>
<script language="javascript">

function openPopupWindow(strDocketNo)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=240,status=no,left=60,top=270"
            var strPopupURL = "docket_tracking.aspx?strDckNo=" + strDocketNo     
            //var strPopupURL = "tckdcktpp.aspx?SessEmpCode=" + '<%=Session["empcd"] %>' + "&SessEmpName=" + '<%=Session["cstnm"] %>' + "&strDckNo=" + strDocketNo + "&Destination=" + strDestination 
            }
            
             function BranchPopup(strPopupURL)
            {
                var strWinFeature = "height=280,width=350,resizable=yes,scrollbars=yes,left=420,top=5"
                
                winNew = window.open(strPopupURL, "_blank", strWinFeature)
            }
function docketpopup(str1)
{
  winNew=window.open(str1,null,"height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15")
}
</script>
<%--<script language="javascript">
function chkall1(val)
{	
    //objCtrl = document.getElementById(checkBoxListId);
    
    var checkBoxList = document.getElementById("CheckBoxList1");
       alert(checkBoxList.length);
       
        if(document.form1.CheckBox111.checked==true)
		    {
		        for(i=1;i<20;i++)
                {
                  CheckBoxList1[i].checked=true;
                }
            }
//	    if(document.form1.CheckBox111.checked==true)
//		    {
//		    for(i=1;i<=20;i++)
//		    {
//    		                
//			    //document.form1.CheckBoxList1.Items[i].checked = true;
//			    objItem.checked= true;
//		    }
//	    }
//	    if(document.form1.CheckBox111.checked==false)
//		    {
//		    for(i=1;i<=20;i++)
//		    {
//			    document.form1.CheckBoxList1.Items(i).Selected = false;
//		    }
//		    //document.form1.CheckBox1.checked=true
//	    }
}</script>--%>
  
    
     <%--<asp:Label ID="lblText" runat="server" Text=""></asp:Label>--%>
     <br />
     <div align="center">    
         <table cellspacing="1" width="100%" align="center">
    
        <tr align="center">
            <td align="center" colspan="2" rowspan="2">
            <div align="center">
                <table cellspacing="1"  class="boxbg" align="center">
                    <tr class="bgbluegrey">
                        <td colspan="5" align="center" style="height: 21px">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td  align="left" style="width: 348px">
                            <asp:UpdatePanel ID="UpdatePanel1"                UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_OnSelectedIndexChange" Width="210px">
                                        <asp:ListItem  Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem  Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                                        <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                        <td valign="top" colspan="4" align="left" nowrap style="width: 300px">
                            <asp:UpdatePanel ID="UpdatePanel2" RenderMode="Inline"               UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                     <A href="#"  onClick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
			   NAME="anchor1"  id="anchor1"><img src="./../../images/calendar.jpg" border="0"></img>
			</A>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    <A href="#"  onClick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
			   NAME="anchor2"  id="a1"><img src="./../../images/calendar.jpg" border="0"></img>
			</A>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom"
                                        ErrorMessage="Date From cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                                        ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                                        ErrorMessage="Date To cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date To  :("
                                        ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                        </td>
                        <td align="left"  valign="top">
                            <asp:Label ID="Label9" runat="server" CssClass="blackfnt" Text="From" Width="102px"></asp:Label></td>
                        <td align="left"  colspan="2" valign="top">
                            <asp:Label ID="Label10" runat="server" CssClass="blackfnt" Text="To" ></asp:Label></td>
                    </tr>
                  <%--  <%Response.Write("<br>loclevel : " + loclevel);%>--%>
                        <tr id="ROWLO" visible="true"  runat="server" style="background-color: white">
                        <td align="left" ><asp:Label ID="Label8"  CssClass="blackfnt" Text="Select RO" runat="server" Width="100%"></asp:Label>
                        </td>
                        <td align="left" colspan="2"  valign="top">
                         
                    <asp:UpdatePanel Id="UP" runat="server"> 
               <ContentTemplate>
                  <asp:DropDownList ID="cboRO" runat="server"  AutoPostBack="true" OnSelectedIndexChanged="cboRO_SelectedIndexChanged" >
                   <%--<asp:ListItem Value="All" Text="All"></asp:ListItem>--%>
                    </asp:DropDownList>
                   </ContentTemplate>
        </asp:UpdatePanel>
                        </td>
                            <td align="left" colspan="1" valign="top">
                              <asp:UpdatePanel Id="UpdatePanel7" runat="server"> 
               <ContentTemplate>
                  <asp:DropDownList ID="cboRO_TO" runat="server"  AutoPostBack="true" OnSelectedIndexChanged="cboRO_SelectedIndexChanged_TO" >
                   <%--<asp:ListItem Value="All" Text="All"></asp:ListItem>--%>
                    </asp:DropDownList>
                   </ContentTemplate>
        </asp:UpdatePanel>
                            </td>
                            
                    </tr>
                    <tr   style="background-color: white">
                        <td align="left"><asp:Label ID="Label7"  CssClass="blackfnt" Text="Select Location" runat="server" Width="102px"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top"> 
                        <asp:UpdatePanel Id="updatepanel8" runat="server"> <ContentTemplate>
                          <asp:DropDownList ID="cboRO_Lo" runat="server" AutoPostBack="true" Mode="Conditional" RenderMode="Inline" Width="102px">
                                    <%-- <asp:ListItem Text="All" Value=""></asp:ListItem>--%>
                          </asp:DropDownList>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboRO" EventName="SelectedIndexChanged" />
                    </Triggers>
                    
                    </asp:UpdatePanel>
                        </td>
                        <td align="left" colspan="1" valign="top">
                        <asp:UpdatePanel Id="updatepanel9" runat="server"> <ContentTemplate>
                          <asp:DropDownList ID="cboRO_Lo_TO" runat="server" AutoPostBack="true" Mode="Conditional" RenderMode="Inline" Width="102px">
                                    <%-- <asp:ListItem Text="All" Value=""></asp:ListItem>--%>
                          </asp:DropDownList>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cboRO_TO" EventName="SelectedIndexChanged" />
                    </Triggers>
                    
                    </asp:UpdatePanel>
                        </td>
                        
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" >
                        <asp:Label ID="lbl"  CssClass="blackfnt" Text="Select Paybas" runat="server" Width="102px"></asp:Label>
                            
                        </td>
                        <td align="left" colspan="5" valign="top" style="width: 231px">
                            <asp:DropDownList ID="DDLPaybas" runat="server">
                            <asp:ListItem Value="All" Text="All"></asp:ListItem>
                            </asp:DropDownList></td>
                    </tr>
                    
                    <tr style="background-color: white">
                        <td align="left"  >
                        <asp:Label ID="Label1"  CssClass="blackfnt" Text="Select Mode" runat="server" Width="100px"></asp:Label>
                            
                        </td>
                        <td align="left" colspan="6" valign="top" >
                            <asp:DropDownList ID="DDLMode" runat="server">
                            <asp:ListItem Value="All" Text="All"></asp:ListItem>
                            </asp:DropDownList></td>
                    </tr>
                    
                     <tr style="background-color: white">
                        <td align="left" >
                        <asp:Label ID="Label3"  CssClass="blackfnt" Text="Select Service Type" runat="server" Width="164px"></asp:Label>
                            
                        </td>
                        <td align="left" colspan="6" valign="top" >
                            <asp:DropDownList ID="DDLType" runat="server">
                            <asp:ListItem Value="All" Text="All"></asp:ListItem>
                            <asp:ListItem Value="Sundry" Text="Sundry"></asp:ListItem>
                             <asp:ListItem Value="FTL" Text="FTL"></asp:ListItem>
                            </asp:DropDownList></td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" >
                            <asp:Label ID="Label11" runat="server" CssClass="blackfnt" Text="Select Status" Width="100px"></asp:Label>
                        </td>
                        <td align="left" colspan="6" valign="top">
                            <asp:DropDownList ID="DDStatus" runat="server">
                                <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                <asp:ListItem Text="Operational" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Quick" Value="10"></asp:ListItem>
                                <asp:ListItem Text="Non Financial" Value="11"></asp:ListItem>
                                <asp:ListItem Text="Financial" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Billed" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Un Billed" Value="3"></asp:ListItem>
                                <asp:ListItem Text="MR - Not Generated" Value="4"></asp:ListItem>
                                <asp:ListItem Text="MR - Generated" Value="5"></asp:ListItem>
                                <asp:ListItem Text="Octroi Paid" Value="6"></asp:ListItem>
                                <asp:ListItem Text="Octroi Not Paid" Value="7"></asp:ListItem>
                                <asp:ListItem Text="Delivered" Value="8"></asp:ListItem>
                                <asp:ListItem Text="Not Delivered" Value="9"></asp:ListItem>
                                <asp:ListItem Text="Door Pickup - Door Delivery" Value="12"></asp:ListItem>
                                <asp:ListItem Text="Door Pickup - Godown Delivery" Value="13"></asp:ListItem>
                                <asp:ListItem Text="Godown Pickup - Godown  Delivery" Value="14"></asp:ListItem>
                                <asp:ListItem Text="Godown Pickup - Door Delivery" Value="15"></asp:ListItem>
                                <asp:ListItem Text="Cancel" Value="16"></asp:ListItem>
                                <asp:ListItem Text="All" Value="All"></asp:ListItem>
                            </asp:DropDownList></td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" >
                            <asp:Label ID="Label12" runat="server" CssClass="blackfnt" Text="Select Yield Range" Width="128px"></asp:Label></td>
                        <td   align="left" colspan="6"  valign="top">
                          <asp:Label ID="Label14" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="Yield1" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    <asp:Label ID="Label15" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="Yield2" runat="Server" ValidationGroup="VGDtFromTo" Width="80" ></asp:TextBox></td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" >
                            <asp:Label ID="Label13" runat="server" CssClass="blackfnt" Text="Enter Customer Code" Width="136px"></asp:Label></td>
                        <td align="left" colspan="6"  valign="top">
                        <asp:TextBox ID="custcd" runat="Server"  Width="80"></asp:TextBox>  <input id="btnBranchPopup" runat="server" onclick="BranchPopup('../Popup_cust.aspx?13')"
                                        type="button" value="..." /></td>
                    </tr>
                    <%--<tr style="background-color: white">
                        <td align="left" colspan="4"  valign="top">
                        </td>
                    </tr>--%>
                    <tr style="background-color: white">
                        <td align="left">
                            <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Text="Enter Document No."
                                Width="173px"></asp:Label></td>
                        <td align="left" colspan="6"  valign="top">
                            <asp:TextBox MaxLength="1000" ID="TextDockets"  Width="254px" runat="server"></asp:TextBox>
                            <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Text="[seperated by <i>comma</i> 
                                  if multiple]"
                                Width="215px"></asp:Label></td>
                    </tr>
                   <%-- <tr style="background-color: white">
                        <td align="left" colspan="4" style="height: 24px" valign="top">
                        </td>
                    </tr>--%>
                    <tr class="bgbluegrey">
                        <td align="left" colspan="6"  valign="top">
                            <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="<b>Docket Details</b>" Width="111px"
                                ></asp:Label>
                           
                        </td>
                         
                        
                    </tr>
                    <tr  style="background-color: white">
                    <td align="right" colspan="6"   valign="bottom">
                          <asp:UpdatePanel ID="UpdatePanel3" RenderMode="Inline"          UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:CheckBox Text="Select All" CssClass="blackfnt" AutoPostBack="true" ID="CheckBox111" runat="server" Width="100%" OnCheckedChanged="chkAll_OnCheckedChanged"  />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                         </td>
                    </tr>
                         
                    
                    
                    <tr style="background-color: white">
                        <td align="left" colspan="6"  valign="top">
                             <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline"         UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                <asp:CheckBoxList ID="CheckBoxList1" runat="server"  CssClass="blackfnt"   RepeatDirection="Horizontal" RepeatColumns="3" TextAlign="right" Width="750px" CellPadding="2" CellSpacing="2"  >
                                <asp:ListItem Selected=True Value="DocketNo" Text="Docket No"></asp:ListItem>
                                <asp:ListItem Value="DocketDate" Text="Docket Date"></asp:ListItem>
                                <asp:ListItem Value="Origin" Text="Origin"></asp:ListItem>
                                <asp:ListItem Value="Destination" Text="Destination"></asp:ListItem>
                                 <asp:ListItem Value="convert(varchar,cdeldt,106) as DeliveryDate" Text="Delivery Date"></asp:ListItem>
                                 <asp:ListItem Value="Dly_loc as 'Delivery Location'" Text="Delivery Location"></asp:ListItem>
                                 <asp:ListItem Value="paybasstr as Paybas" Text="Payment Basis"></asp:ListItem>
                                 <asp:ListItem Value="trnmodstr as TransportMode" Text="Transport Mode"></asp:ListItem>
                                 <asp:ListItem Value="(select codedesc from webx_master_general where  codetype='SVCTYP' and codeid=Service_class) as BookingType" Text="Booking Type"></asp:ListItem>
                                 <asp:ListItem Value="Docket_Mode " Text="Docket Mode "></asp:ListItem>
                                 <asp:ListItem Value="Cnor " Text="Consignor "></asp:ListItem>
                                 <asp:ListItem Value="Cnee " Text="Consignee "></asp:ListItem>
                                 <%--<asp:ListItem Value="BACode " Text="BA Code "></asp:ListItem>--%>
                                 <asp:ListItem Value="PkgsNo " Text="Pkgs. No. "></asp:ListItem>
                                  <asp:ListItem Value="Actuwt as ActualWt" Text="Actual Wt. "></asp:ListItem>
                                 <asp:ListItem Value="ChrgWt as  ChrgWt" Text="Chrg Wt."></asp:ListItem>
                             <%--    <asp:ListItem Value="pickup_door_yn as DoorCollection"  Text="Door Collection"></asp:ListItem>
                                 <asp:ListItem Value="dely_door_yn as  DoorDelivery" Text="Door Delivery"></asp:ListItem>--%>
                                 <asp:ListItem Value="(case when (chrgwt=0 or chrgwt is  null ) then 0 else (cast((dkttot-(cess_svctax))/chrgwt as decimal(9,2) ))  end) as Yield" Text="Yield"></asp:ListItem>
                                 <asp:ListItem Value="FRT_Rate" Text="FRT Rate"></asp:ListItem>  
                                  <asp:ListItem Value="subtotal as 'Basic FRT'" Text=" Basic FRT "></asp:ListItem>  
                                   <asp:ListItem Value="svctax as 'S.tax'" Text="S.tax"></asp:ListItem>  
                                    <asp:ListItem Value="Cess as Cess" Text="Cess"></asp:ListItem>  
                                    <asp:ListItem Value="hedu_cess as 'H.Cess'" Text="H.Cess"></asp:ListItem>
                                    <asp:ListItem Value="dkttot as 'Docket Total'" Text="Docket Total"></asp:ListItem>
                                </asp:CheckBoxList>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="CheckBox111" EventName="CheckedChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    
                    <tr class="bgbluegrey">
                        <td align="left" colspan="4"   valign="top">
                               <asp:Label ID="Label16" runat="server" CssClass="blackfnt" Text="<b>Invoice Details</b>"
                                Width="153px"></asp:Label>
                                 </td>
                                 </tr>
                    <tr  style="background-color: white">
                    <td align="right" colspan="4"   valign="bottom">
                    
                         
                        
                     
                            <asp:UpdatePanel ID="UpdatePanel10" RenderMode="Inline"        UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:CheckBox Text="Select All" Enabled="false" CssClass="blackfnt" AutoPostBack="true" ID="CheckBox1" runat="server" Width="100%" OnCheckedChanged="chkAll_OnCheckedChanged"  />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" colspan="4"  valign="top">
                             <asp:UpdatePanel ID="UpdatePanel11" RenderMode="Inline"       UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                <asp:CheckBoxList Enabled="false" ID="CheckBoxList3" runat="server"  CssClass="blackfnt" RepeatDirection="Horizontal" RepeatColumns="3" TextAlign="right" Width="750px" CellPadding="2" CellSpacing="2"  >
                                <asp:ListItem Selected=True Value="DocketNo" Text="Invoice No"></asp:ListItem>
                                <asp:ListItem Value="DocketDate" Text="Invoice Date"></asp:ListItem>
                                <asp:ListItem Value="Origin" Text="Invoice Amt"></asp:ListItem>
                                </asp:CheckBoxList>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="CheckBox111" EventName="CheckedChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                 <%--   <tr style="background-color: white">
                        <td align="center" colspan="5" style="height: 270px; width: 765px;">
                          <table cellspacing="1" style="width: 100%; height: 21px;">
                  --%>
                      <tr class="bgbluegrey">
                        <td align="left" colspan="5"   valign="top">
                    <asp:Label ID="Label17" runat="server" CssClass="blackfnt" Text="<b>Amount & Charges Details</b>"
                                Width="186px"></asp:Label></td>
                                </tr>
                                 <tr style="background-color: white">
                                <td align="right" colspan="4">
                            <asp:UpdatePanel ID="UpdatePanel12" RenderMode="Inline"      UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:CheckBox Text="Select All" CssClass="blackfnt" AutoPostBack="true" ID="ChkAmtChrgAll" runat="server" Width="100%" OnCheckedChanged="ChkAmtChrgAll_Checked"  />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                                </td>
                            </tr>
                         <tr style="background-color: white">
                             <td align="left" colspan="7" >
                                 <asp:UpdatePanel ID="UpdatePanel13" RenderMode="Inline"     UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                <asp:CheckBoxList ID="ChkAmtChrgDtl" runat="server"  CssClass="blackfnt"   RepeatDirection="Horizontal" RepeatColumns="3" TextAlign="Right" Width="750px"   CellPadding="2" CellSpacing="2"  >
                                </asp:CheckBoxList>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ChkAmtChrgAll" EventName="CheckedChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                         
                    </tr>
                                <tr class="bgbluegrey">
                        <td align="left" colspan="5"   valign="top">
                              <asp:Label ID="Label6" runat="server" CssClass="blackfnt" Text="<b>MR AND Bill Details</b>"
                                Width="178px"></asp:Label>
                                </tr>
                                 <tr style="background-color: white">
                                <td align="right" colspan="4">
                            
                            <asp:UpdatePanel ID="UpdatePanel5" RenderMode="Inline"    UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:CheckBox Text="Select All" CssClass="blackfnt" AutoPostBack="true" ID="CheckBox112" runat="server" Width="100%" OnCheckedChanged="chkAll_OnCheckedChanged2"  />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" colspan="7" >
                             <asp:UpdatePanel ID="UpdatePanel14"  RenderMode="Inline"   UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                <asp:CheckBoxList ID="CheckBoxList2" RepeatColumns="3" TextAlign="Right" runat="server"  CssClass="blackfnt"   RepeatDirection="Horizontal" Width="750px"   CellPadding="2" CellSpacing="2">
                                <asp:ListItem Value="MRSNo" Text="MR No"></asp:ListItem>
                                <asp:ListItem Value="MRSDate=convert(varchar,mrsdt,106)" Text="MR Date"></asp:ListItem>
                                <asp:ListItem Value="BillNo" Text="Bill No"></asp:ListItem>
                                <asp:ListItem Value="Bill_Date=convert(varchar,bgndt,106)" Text="Bill Date"></asp:ListItem>
                                <asp:ListItem Value="party_code as Bill_Party" Text="Bill Party"></asp:ListItem>
                                <asp:ListItem Value="fincmplbr as Bill_Gen_At" Text="Bill Gen. At"></asp:ListItem>
                                 <asp:ListItem Value="billsubbrcd as Bill_Sub_At" Text="Bill Sub. At"></asp:ListItem>
                                  <asp:ListItem Value="billcolbrcd as Bill_Coll_At" Text="Bill Coll. At"></asp:ListItem>
</asp:CheckBoxList>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="CheckBox112" EventName="CheckedChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                                    </td>
                                </tr>
                    
                    
                                <%--<tr style="background-color: white">
                                </tr>--%>
                            </table>
                            </div>
                            <br />
                         <asp:Button ID="btnShow" runat="server" Text="Show"  OnClick="btnShow_Click" Width="75px"  /></td>
                    </tr>
                    <%--<tr style="background-color: white">
                        <td align="center" colspan="5" style="width: 765px">
                            &nbsp;</td>
                    </tr>--%>
                </table>
              
     
   
                
         
                </div>
    
    <%--<table cellspacing="1" style="width: 100%">
        <tr align="center">
            <td align="center">
                <asp:UpdatePanel ID="u1"  UpdateMode="Conditional" runat="server">
                    <ContentTemplate>--%>
                <%--<asp:DataGrid ID="dgSales" runat="server"  CellPadding="4"
  Gridlines="None" HorizontalAlign="Center" OnPageIndexChanged="pgChange" CssClass="bgbluegrey"
 AllowPaging="True" AllowSorting="True"
  HeaderStyle-CssClass="boxborder"
  ItemStyle-CssClass="blackfnt"
     AllowCustomPaging="True"
    PagerStyle-Mode="NumericPages"
    PagerStyle-NextPageText="[Next]"
     PagerStyle-PrevPageText="[Prev]" Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False" Font-Size="Smaller" Font-Strikeout="False" Font-Underline="False" ForeColor="#333333" ShowFooter="True" ><Columns> 
 
 
<asp:TemplateColumn HeaderText="Sr No."> 

   <ItemTemplate > 
       <span ><asp:Label ID="lblsrnocomplainlist" text ="<%#Container.DataSetIndex+1 %>" runat="server">
                                 </asp:Label></span> 
   </ItemTemplate>  
   
   
</asp:TemplateColumn> 
     <asp:HyperLinkColumn  DataNavigateUrlField="DocketNo"    DataNavigateUrlFormatString="tab_new.aspx?DocketNo"
                                                               
                     Target="_blank"   DataTextField="DocketNo" HeaderText="DocketNo"></asp:HyperLinkColumn>
</Columns> 
                   <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <EditItemStyle BackColor="#2461BF" />
                    <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" NextPageText="[Next]" PrevPageText="[Prev]" Mode="NumericPages" Visible="False" />
                    <AlternatingItemStyle BackColor="White" />
                    <ItemStyle BackColor="#EFF3FB" CssClass="blackfnt" />
                    <HeaderStyle BackColor="#507CD1" CssClass="boxborder" Font-Bold="True" ForeColor="White" />

    </asp:DataGrid>--%>
                <%--<asp:GridView ID="dgSales" runat="server" BorderWidth="1" CellSpacing="1" CellPadding="5" 
                            AllowSorting="true" AllowPaging="true" PageSize="10"  PagerSettings-NextPageImageUrl="~/images/next.gif" PagerSettings-PreviousPageImageUrl="~/images/prev.gif" PagerSettings-FirstPageImageUrl="~/images/First.gif" PagerSettings-LastPageImageUrl="~/images/last.gif"  OnPageIndexChanging="pgChange"                            
                            PagerSettings-Mode=NumericFirstLast
                             PagerSettings-Position=TopAndBottom
                               AutoGenerateColumns="false" 
                            BorderColor="#8ba0e5">
                
                
                
                
                       <%--<asp:GridView ID="dgSales" runat="server" BorderWidth="1" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="dgHeaderStyle"
                            AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"                             
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="false" 
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" OnPageIndexChanging="pgChange">--%>
                            <%--<Columns>
                                 <asp:TemplateField HeaderText="SR.NO." >
                                 <ItemTemplate>
                                 <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 </ItemTemplate>
                                 </asp:TemplateField>    
                                                            
                               <asp:BoundField DataField="Dockno" HeaderText="Docket No" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="Dockdt" HeaderText="Docket Date" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="orgncd" HeaderText="Origin" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="paybas" HeaderText="Paybas" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="trn_mod" HeaderText="Mode" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="docket_mode" HeaderText="Type" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                               </Columns>
                             
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>--%>
                       
                        <%--<center>
 <p class="pageLinks">
  <b>Page
  <asp:Label id="CurrentPage" CssClass="pageLinks" runat="server" />
  of
  <asp:Label id="TotalPages" CssClass="pageLinks" runat="server" />
      
 </p>--%>
<%-- <asp:LinkButton runat="server" CssClass="pageLinks"
  id="FirstPage" Text="[First Page]"
  OnCommand="NavigationLink_Click" CommandName="First" />
 <asp:LinkButton runat="server" CssClass="pageLinks"
  id="PreviousPage" Text="[Previous Page]"
  OnCommand="NavigationLink_Click" CommandName="Prev" />
 <asp:LinkButton runat="server" CssClass="pageLinks"
  id="NextPage" Text="[Next Page]"
  OnCommand="NavigationLink_Click" CommandName="Next" />
 <asp:LinkButton runat="server" CssClass="pageLinks"
  id="LastPage" Text="[Last Page]"
  OnCommand="NavigationLink_Click" CommandName="Last" />--%>
 <%--</center>
                        </B>
                    
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnShow" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
               
    

    </td>
        </tr>
    </table>--%>
    
  
				<%--<asp:Button id="Button1" runat="server" Text="Export to excel"></asp:Button>&nbsp;
				<asp:Button id="Button2" runat="server" Text="Export to CSV"></asp:Button>--%>
 
   <DIV ID="testdiv1" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></DIV>
</asp:Content>
