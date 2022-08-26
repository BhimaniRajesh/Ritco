<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"     CodeFile="FuelVendorBillRegister.aspx.cs" Inherits="GUI_Fleet_Reports_VehWiseKMPL" %>
<%@ Register TagName="CMPFT" TagPrefix="Company" Src="~/GUI/Common_UserControls/CompayFilter.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
 <script language="javascript">
    
        function onOk()
        {
            var checkBoxList = document.getElementById("<%=chklstVehNo.ClientID %>");
            if(checkBoxList !=null)
            {
                var options = checkBoxList.getElementsByTagName('input');
                var arrayOfCheckBoxLabels= checkBoxList.getElementsByTagName("label");
                document.getElementById("<%=txtVehNo.ClientID %>").value="";
                for(i=0;i<options.length;i++)
                {
                    var opt = options[i];
                    if(opt.checked)
                    {
                        document.getElementById("ctl00$MyCPH1$txtVehNo").value = document.getElementById("ctl00$MyCPH1$txtVehNo").value+arrayOfCheckBoxLabels[i].innerText+",";
                    }
                } 
                var str=document.getElementById("ctl00$MyCPH1$txtVehNo").value;
                var len=str.length;
                str=str.substring(0,len-1);
                document.getElementById("ctl00$MyCPH1$txtVehNo").value = str;
            }
            return;
        }
        function onCancel()
        {
            document.getElementById("<%=txtVehNo.ClientID %>").value="";
            var checkBoxList = document.getElementById("<%=chklstVehNo.ClientID %>");
            if(checkBoxList !=null)
            {
                var options = checkBoxList.getElementsByTagName('input');
                var arrayOfCheckBoxLabels= checkBoxList.getElementsByTagName("label");
                for(i=0;i<options.length;i++)
                {
                    var opt = options[i];
                    opt.checked = false;
                } 
            }
            return;
        }
        
 
   
        function Validation()
        {
            if(document.getElementById("<%=txtDateFrom.ClientID %>").value == ""  && document.getElementById("<%=txtDateTo.ClientID %>").value != "")
            {
                if(document.getElementById("<%=txtDateFrom.ClientID %>").value == "")
                {
                    document.getElementById("<%=txtDateFrom.ClientID %>").focus(); 
                    alert("Enter From Date Range!!!")
                    return false;
                }
            }
            else if(document.getElementById("<%=txtDateFrom.ClientID %>").value != ""  && document.getElementById("<%=txtDateTo.ClientID %>").value == "")
            {
                if(document.getElementById("<%=txtDateTo.ClientID %>").value == "")
                {
                    document.getElementById("<%=txtDateTo.ClientID %>").focus(); 
                    alert("Enter To Date Value Range!!!")
                    return false;
                }
            }
        }
        function CehckText()
        {
            var vehno=document.getElementById("<%=txtVehNo.ClientID %>");
            var ddlDocument=document.getElementById("<%=ddlDocument.ClientID %>");
            if(ddlDocument.value == "1")
            {
                if(vehno.value=="")
                {
                    alert("Please Select Bill Entry Number!!!");
                    vehno.focus();
                    return false;
                }
            }
            if(ddlDocument.value == "2")
            {
                if(vehno.value=="")
                {
                    alert("Please Select Manual Bill Number!!!");
                    vehno.focus();
                    return false;
                }
            }
            if(ddlDocument.value == "3")
            {
                if(vehno.value=="")
                {
                    alert("Please Select Vehicle Number!!!");
                    vehno.focus();
                    return false;
                }
            }
              function cust(ID)
        {
         ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        } 
        }
//         function OnSub_DATACHECK()
//    {
//        window.open("FuelVendorBillRegisterResult.aspx","");
//        return false;
//    }
    </script> 

<asp:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports >Fuel Vendor Bill Register</asp:Label>
            </td> 
            
             <td align="right">

          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
      <table cellspacing="1" style="width: 700px">
            <tr >
                <td>  
       <table cellspacing="1" cellpadding="2" style="width: 100%" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="4" align="center" style="vertical-align: top; width: 25%; text-align: left">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                            </td>
                        </tr>
                         <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                        <td   align="left" colspan="1" style="width: 250px"  >
                            <asp:Label ID="Label2"  Font-Bold="True" CssClass="blackfnt" Text="Select Company Type" runat="server"></asp:Label>
                        </td>
                        <td align="left" valign="top"  colspan="2" >
                           <Company:CMPFT ID="CMPFT1" runat="server" />
                       </td>
                    </tr> 
                      
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 25%; text-align: left">
                   <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Font-Bold="True">Fuel Vendor:</asp:Label></td>
               <td align="left" colspan="1" style="width: 2%">
               </td>
               <td align="left" colspan="2" style="width: 73%">
                   <asp:DropDownList ID="ddlVendorType" runat="server" Width="199px">
                   </asp:DropDownList></td>
           </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 25%; text-align: left">
                   <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="True" Width="160px">Vendor Bill Entry Date:</asp:Label></td>
               <td align="left" colspan="1" style="width: 2%">
                   <asp:RadioButton ID="rbDate" runat="server" GroupName="DateRange" /></td>
               <td align="left" colspan="2" style="width: 73%">
                                       <asp:Label ID="Label7" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                        <asp:TextBox CssClass="input" ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo"
                                            Width="80" BorderStyle="Groove"></asp:TextBox>
                                            <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" 
                                        Format="dd/MM/yyyy"
                                        TargetControlID="txtDateFrom"   runat="server" />
                                       <asp:Label ID="Label8" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                        <asp:TextBox CssClass="input" ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo"
                                            Width="80" BorderStyle="Groove"></asp:TextBox> 
                                            <ajaxToolkit:CalendarExtender ID="CalendarExtender1" 
                                        Format="dd/MM/yyyy"
                                        TargetControlID="txtDateTo"   runat="server" />
                                            </td>
           </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 25%; text-align: left">
               </td>
               <td align="left" colspan="1" style="width: 2%">
                   <asp:RadioButton ID="rbLastWeek" runat="server" GroupName="DateRange" /></td>
               <td align="left" colspan="2" style="width: 73%">
                   Last Week</td>
           </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 25%; text-align: left">
               </td>
               <td align="left" colspan="1" style="width: 2%">
                   <asp:RadioButton ID="rbToday" runat="server" GroupName="DateRange" /></td>
               <td align="left" colspan="2" style="width: 73%">
                   Today</td>
           </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 25%; text-align: left">
               </td>
               <td align="left" colspan="1" style="width: 2%">
               </td>
               <td align="left" colspan="2" style="width: 73%; text-align: right">
                   <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                       <ContentTemplate>
                           <asp:Button ID="btnShow1" runat="server" Text="Submit" OnClientClick="Javascript: return OnSub_DATACHECK();"    OnClick="btnShow_Click" />
                       </ContentTemplate>
                   </asp:UpdatePanel>
               </td>
           </tr>
           <tr style="background-color: white">
               <td align="right" colspan="4" style="font-weight: bold; vertical-align: middle; height: 34px;
                   text-align: center">
                   OR</td>
           </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 25%; text-align: left">
                   <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="True">Select Document:</asp:Label></td>
               <td align="left" colspan="1" style="width: 2%">
               </td>
               <td align="left" colspan="2" style="width: 73%">
              <asp:UpdatePanel ID="UpdatePanel2" runat="server">
    <ContentTemplate>

                   <asp:DropDownList ID="ddlDocument" runat="server" OnSelectedIndexChanged="ddlDocument_SelectedIndexChanged"
                       Width="205px" AutoPostBack="True">
                   </asp:DropDownList>
                
                                   </ContentTemplate>
    </asp:UpdatePanel>
                
               </td>
           </tr>
                    
           <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; width: 25%; text-align: left">
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:Label ID="lblDocument" runat="server" CssClass="blackfnt" Font-Bold="True"></asp:Label>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                       
                         
                        </td>
               <td align="left" colspan="1" style="width: 2%">
               </td>
                        <td align="left" colspan="2" style="width: 73%; vertical-align: top; text-align: left;">
                             <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>

                            <asp:TextBox ID="txtVehNo" runat="server" CssClass="input" Width="386px" style="font-size: 8pt; font-family: Verdana" ></asp:TextBox>
                            <asp:LinkButton ID="lnkbtnSelect" runat="server" Font-Underline="True" ForeColor="Blue">Select</asp:LinkButton>
                            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" EnableViewState="False"
                            TargetControlID="lnkbtnSelect" 
                            PopupControlID="Panel1" 
                            BackgroundCssClass="modalBackground" 
                            DropShadow="True" 
                            OkControlID="btnSubmit" 
                            OnCancelScript="onCancel()"  
                            OnOkScript="onOk()" 
                            CancelControlID="btnCancle" />
                              </ContentTemplate>
                            </asp:UpdatePanel>
                            
                             <asp:Panel ID="Panel2" runat="server" Height="1px" Width="1px">
            
    <asp:Panel id="Panel1" runat="server" Height="540px" BackColor="White" Width="673px"><TABLE style="WIDTH: 90%" cellSpacing=0 cellPadding=0><TBODY><TR><TD style="VERTICAL-ALIGN: top; WIDTH: 100px; TEXT-ALIGN: left; height: 514px;"><asp:Panel style="VERTICAL-ALIGN: top; TEXT-ALIGN: left" id="pnlModal" runat="server" Height="500px" Font-Size="10pt" BackColor="White" Font-Names="Verdana" Width="670px" ScrollBars="Vertical">
    
    <asp:UpdatePanel ID="UpdatePanel6" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
    <asp:CheckBoxList id="chklstVehNo" runat="server" Font-Size="8pt" Font-Names="Verdana" Width="650px" RepeatDirection="Horizontal" RepeatColumns="5" CellSpacing="0" CellPadding="1">
                    </asp:CheckBoxList>
        </ContentTemplate>
    </asp:UpdatePanel>
    </asp:Panel></TD></TR><TR><TD style="WIDTH: 100%; HEIGHT: 24px; TEXT-ALIGN: center">
                    <asp:Button id="btnSubmit" runat="server" Text="Submit">
                    </asp:Button> <asp:Button id="btnCancle"  runat="server" Text="Cancle"></asp:Button>
                    </TD></TR></TBODY></TABLE>
                    </asp:Panel>
                            </asp:Panel>
                              
                            </td>
                    </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 25%; text-align: left">
               </td>
               <td align="left" colspan="1" style="width: 2%">
               </td>
               <td align="left" colspan="2" style="text-align: right; width: 73%;">
                        <asp:Button ID="btnShow" runat="server" Text="Submit" OnClientClick="Javascript: return OnSub_DATACHECK();"   OnClick="btnShow_Click" /> 
               </td>
           </tr>

                       </table>
                    
                   </td>
            </tr>
        </table>
 
    <br> 
               
   
</asp:Content> 
