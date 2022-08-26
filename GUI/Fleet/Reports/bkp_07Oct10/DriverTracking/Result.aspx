<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_Fleet_Reports_DriverTracking_Result" Title="Untitled Page" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Src="~/GUI/Fleet/Reports/AutoComplete/MAC.ascx" TagName="AutoComplete" TagPrefix="auc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script src="../../../images/commonJs.js"  language="javascript" type="text/javascript"></script>

<script language="javascript" type="text/javascript">  
//function nwOpen()
//{
//    window.open("Popup-Driver1.aspx?","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
//}

//function createXMLHttpRequest()
//{
//    // Mozilla, Safari,...
//    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
//    // IE
//    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
//}

//function CheckDriverManualCode(tb_Driver_Name,hfDriverCode)
//{
//    var currentTime = new Date();
//    var lblError=document.getElementById("ctl00_MyCPH1_lblError");

//    createXMLHttpRequest();
//    if (xmlHttpRequest)
//    {
//        xmlHttpRequest.onreadystatechange = function()
//        {
//            if (xmlHttpRequest.readyState == 4)
//            {
//                var returnValue=xmlHttpRequest.responseText.split("~");
//                if (returnValue[0] == "N") 
//                {
//                    lblError.innerText="Invalid Driver Name!!!";
//                    return false;
//                }
//                else
//                {
//                    lblError.innerText="";
//                    tb_Driver_Name.value=returnValue[1];
//                    hfDriverCode.value=returnValue[2];
//                }
//            }
//            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckDriverManualCode&datetime="+currentTime+"&Driver_Name="+tb_Driver_Name.value, false);
//            xmlHttpRequest.send(null);
//        }
//    }
//}

</script>
<script language="javascript" type="text/javascript">
var controlIdPrefix = "ctl00_MyCPH1_";

function nwOpenViewWindow() 
{
    if (document.getElementById(controlIdPrefix + "txtDriverID").value == "")
        alert("Please Enter Manual Driver Code");
    else
    //window.open("DriverTrackingView.aspx?Manual_Driver_Code="+ document.getElementById(controlIdPrefix + "tb_Driver_Name").value,"myWindow","height=500,width=950,left=25,top=100,resizable=yes,scrollbars=yes");
    window.open("DriverTrackingView.aspx?Driver_Id="+ document.getElementById(controlIdPrefix + "txtDriverID").value,"myWindow","height=500,width=950,left=25,top=100,resizable=yes,scrollbars=yes");
}

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
        
    <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Fleet</strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>Reports </strong></font><strong>&gt; </strong>
                <font class="bluefnt"><strong>Driver Tracker Report</strong></font>&nbsp;</td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr>
            <td>
                <img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
    </table>   
    <br />
    <br />
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    
 <table width="100%">
    <tr>
    <td>
    
    <asp:Table ID="Table2" runat="server" HorizontalAlign="left" CssClass="boxbg"
            CellSpacing="1" BorderWidth="0" Width="800px" BorderStyle="Groove">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="center" ColumnSpan="6" CssClass="blackfnt" Style="height: 20px;">
                    <b>Criteria</b>
                    <asp:HiddenField ID="hfDate" runat="server" />
                </asp:TableCell>
            </asp:TableRow>

            <asp:TableRow CssClass="bgwhite" HorizontalAlign="left" VerticalAlign="Middle">
                <asp:TableCell Width="130px">
                    Enter Driver Name : 
                </asp:TableCell> 
                <asp:TableCell Width="600px">
                    <asp:TextBox ID="txtDriverID" runat="server" CssClass="bgwhite" BorderStyle="Groove"
                        Width="150px"></asp:TextBox>
                    <asp:TextBox ID="txt_DriverName" runat="server" CssClass="bgwhite" onfocus="this.blur()"  
                        Width="250px" BorderStyle="Groove"></asp:TextBox><br />
                    <auc:AutoComplete ID="aucDriver" MinPrefixLength="1" runat="server" WebxEntity="Driver"
                        CodeTarget="txtDriverID" NameTarget="txt_DriverName" />
                    <asp:Label ID="lblError"  runat="server" CssClass="redfnt" Font-Bold="true" ></asp:Label>
                    <td class="blackfnt" style="text-align: center">
                        <a href="javascript:nwOpenViewWindow()" class="blackfnt">View</a>
                    </td>
                </asp:TableCell>
            </asp:TableRow>
            
            <asp:TableRow CssClass="bgwhite" HorizontalAlign="left">
                <asp:TableCell ColumnSpan="1" HorizontalAlign="Left" Width="130px">
                     <asp:UpdatePanel ID="UpdatePanel2" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                        <ContentTemplate>
                            <asp:Button ID="btnShow" runat="server" Text="Show Driver Data"  OnClick="btnShow_Click" /> 
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:TableCell>
                <asp:TableCell ColumnSpan="4" HorizontalAlign="left" Width="700px">
                     <asp:Label ID="Label2" runat="server" CssClass="blackfnt"></asp:Label>
                </asp:TableCell> 
            </asp:TableRow>
                        
    </asp:Table> 

    </td>
    </tr>

     <caption>
         <tr>
             <td>
                 <br></br>
                 <ajaxToolkit:TabContainer ID="tabDriverStatus" runat="server" 
                     ActiveTabIndex="0" CssClass="ajax__tab_yuitabview-theme" Height="800px" 
                     Width="100%">
                     <ajaxToolkit:TabPanel ID="tabDriverPersonalInfo" runat="server" 
                         HeaderText="Driver Personal Information">
                         <HeaderTemplate>
                             Driver Personal Information
                         </HeaderTemplate>
                         <ContentTemplate>
                             <asp:Table ID="tblMain" runat="server" BorderStyle="Groove" BorderWidth="0" 
                                 CellPadding="5" CellSpacing="1" CssClass="boxbg" HorizontalAlign="left" 
                                 Width="800px">
                                 <asp:TableRow CssClass="bgbluegrey">
                                     <asp:TableCell ColumnSpan="5" CssClass="blackfnt" HorizontalAlign="center" 
                                         Style="height: 20px;"> <b>Driver Personal Information</b>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left" Width="150px"> Driver Name :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="200px">
                                     <asp:Label ID="lblDriverName" runat="server" CssClass="blackfnt"></asp:Label>
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="150px"> Father Name :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="200px">
                                     <asp:Label ID="lblFatherName" runat="server" CssClass="blackfnt"></asp:Label>
                                     </asp:TableCell>
                                     <asp:TableHeaderCell RowSpan="4">
                                     <asp:Image ID="ImgPhoto" runat="server" Height="150px" Visible="false" 
                                         Width="150px" />
                                     </asp:TableHeaderCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left" Width="150px"> Location :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="200px">
                                     <asp:Label ID="lblLocation" runat="server" CssClass="blackfnt"></asp:Label>
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="150px"> Contact No. :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="200px">
                                     <asp:Label ID="lblContactNo" runat="server" CssClass="blackfnt"></asp:Label>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left" VerticalAlign="Top" Width="150px" 
                                         Wrap="false"> Permanent Address :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="200px">
                                     <asp:Label ID="lbl_P_Addr" runat="server" CssClass="blackfnt"></asp:Label>
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" VerticalAlign="Top" Width="150px"> Current 
                                     Address :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="200px">
                                     <asp:Label ID="lbl_C_Addr" runat="server" CssClass="blackfnt"></asp:Label>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left" Width="150px" Wrap="false"> Permanent City 
                                     &amp; Pincode :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="200px">
                                     <asp:Label ID="lbl_P_City_Pincode" runat="server" CssClass="blackfnt"></asp:Label>
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="150px" Wrap="false"> Current City &amp; 
                                     Pincode :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="200px">
                                     <asp:Label ID="lbl_C_City_Pincode" runat="server" CssClass="blackfnt"></asp:Label>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell ColumnSpan="5" HorizontalAlign="left"> <b>Other Information : </b>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left" Width="150px"> Manual Driver Code :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="200px">
                                     <asp:Label ID="lbl_Manual_Driver_Code" runat="server" CssClass="blackfnt"></asp:Label>
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="150px"> Vehicle No. :
                                     </asp:TableCell>
                                     <asp:TableCell ColumnSpan="2" HorizontalAlign="left" Width="350px">
                                     <asp:Label ID="lbl_VehicleNo" runat="server" CssClass="blackfnt"></asp:Label>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left" Width="150px"> License No. :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="200px">
                                     <asp:Label ID="lbl_LicenseNo" runat="server" CssClass="blackfnt"></asp:Label>
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="150px"> Validity date :
                                     </asp:TableCell>
                                     <asp:TableCell ColumnSpan="2" HorizontalAlign="left" Width="350px">
                                     <asp:Label ID="lbl_ValidityDt" runat="server" CssClass="blackfnt"></asp:Label>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left" Width="150px"> Issued By RTO :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="200px">
                                     <asp:Label ID="lbl_IssuedByRTO" runat="server" CssClass="blackfnt"></asp:Label>
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="150px"> Guarantor name :
                                     </asp:TableCell>
                                     <asp:TableCell ColumnSpan="2" HorizontalAlign="left" Width="350px">
                                     <asp:Label ID="lblGuarrantorName" runat="server" CssClass="blackfnt"></asp:Label>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left" Width="150px"> Active/In-active :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="200px">
                                     <asp:Label ID="lblActive" runat="server" CssClass="blackfnt"></asp:Label>
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="150px"> Driver Status :
                                     </asp:TableCell>
                                     <asp:TableCell ColumnSpan="2" HorizontalAlign="left" Width="350px">
                                     <asp:Label ID="lbl_DriverStatus" runat="server" CssClass="blackfnt"></asp:Label>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell ColumnSpan="1" HorizontalAlign="left" Width="150px"> Current 
                                     Driver Balance :
                                     </asp:TableCell>
                                     <asp:TableCell ColumnSpan="4" HorizontalAlign="left" Width="700px">
                                     <asp:Label ID="lbl_Balance" runat="server" CssClass="blackfnt"></asp:Label>
                                     </asp:TableCell>
                                 </asp:TableRow>
                             </asp:Table>
                         </ContentTemplate>
                     </ajaxToolkit:TabPanel>
                     <ajaxToolkit:TabPanel ID="tabDriverAddress" runat="server" 
                         HeaderText="Driver Address ID Proof">
                         <ContentTemplate>
                             <asp:Table ID="Table1" runat="server" BorderStyle="Groove" BorderWidth="0" 
                                 CellPadding="5" CellSpacing="1" CssClass="boxbg" HorizontalAlign="left" 
                                 Width="600px">
                                 <asp:TableRow CssClass="bgbluegrey">
                                     <asp:TableCell ColumnSpan="2" CssClass="blackfnt" HorizontalAlign="center" 
                                         Style="height: 20px;"> <b>Driver Address ID Proof</b>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left" Width="30%"> Electricity Bill :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left" Width="70%">
                                     <asp:Label ID="lbl_ElectricityBill" runat="server" CssClass="blackfnt"></asp:Label>
                                     <asp:HiddenField ID="hfEleBillFile" runat="server" />
                                     &nbsp;
                                     <asp:HyperLink ID="hyperEleBill" runat="server" Target="_blank" Text="View" 
                                         Visible="false"></asp:HyperLink>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left"> Telephone Bill :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left">
                                     <asp:Label ID="lbl_TelephoneBill" runat="server" CssClass="blackfnt"></asp:Label>
                                     <asp:HiddenField ID="hfTelBill" runat="server" />
                                     &nbsp;
                                     <asp:HyperLink ID="HyperTelBill" runat="server" Target="_blank" Text="View" 
                                         Visible="false"></asp:HyperLink>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left"> Bank Account Statement :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left">
                                     <asp:Label ID="lbl_BankStatement" runat="server" CssClass="blackfnt"></asp:Label>
                                     <asp:HiddenField ID="hfBankStatement" runat="server" />
                                     &nbsp;
                                     <asp:HyperLink ID="HyperBankStatement" runat="server" Target="_blank" 
                                         Text="View" Visible="false"></asp:HyperLink>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left"> Passport :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left">
                                     <asp:Label ID="lbl_Passport" runat="server" CssClass="blackfnt"></asp:Label>
                                     <asp:HiddenField ID="hfPassport" runat="server" />
                                     &nbsp;
                                     <asp:HyperLink ID="HyperPassport" runat="server" Target="_blank" Text="View" 
                                         Visible="false"></asp:HyperLink>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left"> Ration card :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left">
                                     <asp:Label ID="lbl_RationCard" runat="server" CssClass="blackfnt"></asp:Label>
                                     <asp:HiddenField ID="hfrationCard" runat="server" />
                                     &nbsp;
                                     <asp:HyperLink ID="HyperrationCard" runat="server" Target="_blank" Text="View" 
                                         Visible="false"></asp:HyperLink>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left"> Driver&#39;s Regsitration Form :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left">
                                     <asp:Label ID="lblRegForm" runat="server" CssClass="blackfnt"></asp:Label>
                                     <asp:HiddenField ID="hfRegForm" runat="server" />
                                     &nbsp;
                                     <asp:HyperLink ID="HyperRegForm" runat="server" Target="_blank" Text="View" 
                                         Visible="false"></asp:HyperLink>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell ColumnSpan="2" HorizontalAlign="left"> <b>ID Proof Details : </b>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left"> Passport :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left">
                                     <asp:Label ID="lbl_PassportID" runat="server" CssClass="blackfnt"></asp:Label>
                                     <asp:HiddenField ID="hfPassportID" runat="server" />
                                     &nbsp;
                                     <asp:HyperLink ID="HyperPassportID" runat="server" Target="_blank" Text="View" 
                                         Visible="false"></asp:HyperLink>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left"> Driving License :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left">
                                     <asp:Label ID="lbl_DrivingLicense" runat="server" CssClass="blackfnt"></asp:Label>
                                     <asp:HiddenField ID="hfDrivingLicense" runat="server" />
                                     &nbsp;
                                     <asp:HyperLink ID="HyperDrivingLicense" runat="server" Target="_blank" 
                                         Text="View" Visible="false"></asp:HyperLink>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left"> Voter&#39;s ID :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left">
                                     <asp:Label ID="lbl_VotersID" runat="server" CssClass="blackfnt"></asp:Label>
                                     <asp:HiddenField ID="hfVotersID" runat="server" />
                                     &nbsp;
                                     <asp:HyperLink ID="HyperVotersID" runat="server" Target="_blank" Text="View" 
                                         Visible="false"></asp:HyperLink>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left"> PAN Card :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left">
                                     <asp:Label ID="lbl_PanCard" runat="server" CssClass="blackfnt"></asp:Label>
                                     <asp:HiddenField ID="hfPANcard" runat="server" />
                                     &nbsp;
                                     <asp:HyperLink ID="HyperPANcard" runat="server" Target="_blank" Text="View" 
                                         Visible="false"></asp:HyperLink>
                                     </asp:TableCell>
                                 </asp:TableRow>
                                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                                     <asp:TableCell HorizontalAlign="left"> Thumb Impression :
                                     </asp:TableCell>
                                     <asp:TableCell HorizontalAlign="left">
                                     <asp:Label ID="lbl_ThumbImp" runat="server" CssClass="blackfnt"></asp:Label>
                                     <asp:HiddenField ID="hfThumbImp" runat="server" />
                                     &nbsp;
                                     <asp:HyperLink ID="HyperThumbImp" runat="server" Target="_blank" Text="View" 
                                         Visible="false"></asp:HyperLink>
                                     </asp:TableCell>
                                 </asp:TableRow>
                             </asp:Table>
                         </ContentTemplate>
                     </ajaxToolkit:TabPanel>
                     <ajaxToolkit:TabPanel ID="tabFuelRegister" runat="server" 
                         HeaderText="Fuel Register">
                         <ContentTemplate>
                             <asp:GridView ID="gvFuelRegister" runat="server" AutoGenerateColumns="false" 
                                 BorderWidth="0" CellPadding="5" CellSpacing="1" CssClass="boxbg" 
                                 EmptyDataRowStyle-CssClass="bgbluegrey" EmptyDataText="No Reocord Found" 
                                 FooterStyle-CssClass="bgwhite" HeaderStyle-CssClass="bgbluegrey" 
                                 PagerSettings-Mode="NumericFirstLast" SelectedIndex="1" Width="100%">
                                 <Columns>
                                     <asp:TemplateField HeaderText="Tripsheet No." ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"TripsheetNo") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Left" Width="10%" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Vehicle No." ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"VehicleNo") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Left" Width="10%" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Date of Filling" ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"Date_of_Filling") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Left" Width="10%" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Reference Doc. No." ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemStyle Width="100px" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"Ref_Doc_No") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Right" Width="10%" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Fuel Filled in Ltrs." 
                                         ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemStyle Width="100px" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"Diesel_Ltr") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Right" Width="10%" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Diesel Rate" ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"Diesel_Rate") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Right" Width="10%" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Fuel Cost" ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"Fuel_Cost") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Right" Width="10%" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Odometer" ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"Odometer") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Right" Width="10%" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Payment Method" ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"Payment_Method") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Left" Width="10%" />
                                     </asp:TemplateField>
                                 </Columns>
                             </asp:GridView>
                         </ContentTemplate>
                     </ajaxToolkit:TabPanel>
                     <ajaxToolkit:TabPanel ID="tabTripsheetInfo" runat="server" 
                         HeaderText="Tripsheet Related Info">
                         <ContentTemplate>
                             <asp:GridView ID="gvTripsheet" runat="server" AutoGenerateColumns="false" 
                                 BorderWidth="0" CellPadding="5" CellSpacing="1" CssClass="boxbg" 
                                 EmptyDataRowStyle-CssClass="bgbluegrey" EmptyDataText="No Reocord Found" 
                                 FooterStyle-CssClass="bgwhite" HeaderStyle-CssClass="bgbluegrey" 
                                 PagerSettings-Mode="NumericFirstLast" SelectedIndex="1" Width="100%">
                                 <Columns>
                                     <asp:TemplateField HeaderText="Tripsheet No." ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"VSlipNo") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Left" Width="10%" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Tripsheet Date" ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"VSlipDt") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Left" Width="10%" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Manual Trip No." ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"Manual_TripsheetNo") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Right" Width="10%" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Vehicle No." ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemStyle Width="100px" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"VehicleNo") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Left" Width="10%" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Trip Start Location" 
                                         ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemStyle Width="10px" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"Tripsheet_StartLoc") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Left" Width="10%" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Trip Close Location" 
                                         ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"Tripsheet_EndLoc") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Left" Width="10%" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Advance Paid" ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemStyle Width="10px" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"Advamt") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Right" Width="10%" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Balance Paid" ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"BalancePaid") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Right" Width="10%" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Trip Category" ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"Category") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Left" Width="10%" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Trip Status" ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"Trip_Status") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Left" Width="10%" />
                                     </asp:TemplateField>
                                 </Columns>
                             </asp:GridView>
                         </ContentTemplate>
                     </ajaxToolkit:TabPanel>
                     <ajaxToolkit:TabPanel ID="tabVehicleInfo" runat="server" 
                         HeaderText="Vehicle Used Most Frequently">
                         <ContentTemplate>
                             <asp:GridView ID="gvVehicleUsed" runat="server" AutoGenerateColumns="false" 
                                 BorderWidth="0" CellPadding="5" CellSpacing="1" CssClass="boxbg" 
                                 EmptyDataRowStyle-CssClass="bgbluegrey" EmptyDataText="No Reocord Found" 
                                 FooterStyle-CssClass="bgwhite" HeaderStyle-CssClass="bgbluegrey" 
                                 PagerSettings-Mode="NumericFirstLast" SelectedIndex="1" Width="600px">
                                 <Columns>
                                     <asp:TemplateField HeaderText="Vehicle No." ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"vehicleno") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Left" Width="300px" />
                                     </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Total Tripsheet Count" 
                                         ItemStyle-CssClass="bgwhite">
                                         <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                         <ItemTemplate>
                                             <asp:Label ID="Label1" runat="server" 
                                                 Text='<%# DataBinder.Eval(Container.DataItem,"TripSheet_Count") %>'></asp:Label>
                                         </ItemTemplate>
                                         <ItemStyle CssClass="bgwhite" HorizontalAlign="Right" Width="300px" />
                                     </asp:TemplateField>
                                 </Columns>
                             </asp:GridView>
                         </ContentTemplate>
                     </ajaxToolkit:TabPanel>
                 </ajaxToolkit:TabContainer>
                 </br>
                 </br>
                 </br>
                 </br>
             </td>
         </tr>
         </br>
         </br>
     </caption>
    </table>
    </ContentTemplate>
    </asp:UpdatePanel>

               
</asp:Content>

