<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"     CodeFile="VehTyrePosSummary.aspx.cs" Inherits="GUI_Fleet_Reports_VehTyrePosSummary" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AtlasControlToolkit" Namespace="AtlasControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript">
        function numeric(e) { return ((e.keyCode == 8 ) || (e.keyCode > 47 && e.keyCode <58)); }
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
                        document.getElementById("<%=txtVehNo.ClientID %>").value = document.getElementById("<%=txtVehNo.ClientID %>").value+arrayOfCheckBoxLabels[i].innerText+",";
                    }
                } 
                var str=document.getElementById("<%=txtVehNo.ClientID %>").value;
                var len=str.length;
                str=str.substring(0,len-1);
                document.getElementById("<%=txtVehNo.ClientID %>").value = str;
            }
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
        }
        
        
    </script>
    <script language="javascript">
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
     
    </script> 

<atlas:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</atlas:UpdateProgress>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports >Vehicle Tyre Position Change</asp:Label>
            </td> 
            
             <td align="right">

          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
      <br> 
      <table cellspacing="1" style="width: 700px">
            <tr >
                <td>  
       <table cellspacing="1" cellpadding="2" style="width: 100%" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="3" align="center">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                            </td>
                        </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 154px; text-align: left">
                   <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="True">Tyre Position Change Date Range:</asp:Label></td>
               <td align="left" colspan="2">
                                       <asp:Label ID="Label7" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                        <asp:TextBox CssClass="input" ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo"
                                            Width="80" BorderStyle="Groove"></asp:TextBox>
                                       <asp:image id="img_CalendarF" runat="server" ImageUrl="~/cal/cal.gif" BackColor="White" BorderColor="White" ForeColor="White"></asp:image>   
                                        <asp:Label ID="Label8" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                        <asp:TextBox CssClass="input" ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo"
                                            Width="80" BorderStyle="Groove"></asp:TextBox> <asp:Image ID="img_CalendarT" runat="server" BackColor="White" BorderColor="White"
                                        ForeColor="White" ImageUrl="~/cal/cal.gif" /></td>
           </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 154px; text-align: left">
                   <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="True">Select Vehicle No:</asp:Label></td>
               <td align="left" colspan="2">
                            <asp:TextBox ID="txtVehNo" runat="server" CssClass="input" Width="423px" style="font-size: 8pt; font-family: Verdana" ></asp:TextBox>
                            <asp:LinkButton ID="lnkbtnSelect" runat="server">Select Vehicle</asp:LinkButton>
                            <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server">
                            <cc1:ModalPopupProperties TargetControlID="lnkbtnSelect" PopupControlID="Panel1" BackgroundCssClass="modalBackground" DropShadow="True" OkControlID="btnSubmit" OnCancelScript="onCancel()"  OnOkScript="onOk()" CancelControlID="btnCancle" />
                            </cc1:ModalPopupExtender>
               </td>
           </tr>
           <tr style="background-color: white">
               <td align="right" colspan="3" style="font-weight: bold; font-size: 10pt; vertical-align: middle;
                   font-family: Verdana; text-align: center">
                   OR</td>
           </tr>
                    
           <tr style="background-color: white">
                        <td align="right" style="vertical-align: top; width: 154px; text-align: left">
                            <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="True">Vehicles where Position not changed for</asp:Label></td>
                        <td align="left" colspan="2">
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="input"  onkeydown="return numeric(event)" Width="41px"></asp:TextBox></td>
                    </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 154px; text-align: left">
               </td>
               <td align="left" colspan="2" style="text-align: right">
                <atlas:UpdatePanel ID="UpdatePanel8" Mode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="btnShow" runat="server" Text="Submit" OnClientClick="javascript:return Validation()"  OnClick="btnShow_Click" /> 
                    </ContentTemplate>
                </atlas:UpdatePanel>
               </td>
           </tr>

                       </table>
                    
                   </td>
            </tr>
        </table>
      <br/>
       
   <table cellspacing="1" style="width: 100%" align="center">
        <tr style="background-color: white">
            <td colspan="3" align="center">
                &nbsp;</td>
        </tr>
        
    </table><table cellspacing="1" style="width: 100%" align="center">
        <tr style="background-color: white">
            <td colspan="3" align="center" style="vertical-align: top; text-align: left">
                <atlas:UpdatePanel ID="UpdatePanel1" Mode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                       <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:reportviewer id="ReportViewer1" runat="server" processingmode="Remote" Height="1000px" Width="1400px">
                        </rsweb:reportviewer>
                    </ContentTemplate>
                </atlas:UpdatePanel>
            </td>
        </tr>
    </table>
    <br />
    
                     <asp:Panel ID="Panel1" runat="server" Height="500px" Style="vertical-align: top; text-align: left"
                    Width="670px" ScrollBars="Vertical" BackColor="White" Font-Names="Verdana" Font-Size="10pt">
                    <table cellpadding="0" cellspacing="0" style="width: 90%">
                        <tr>
                            <td style="vertical-align: top; width: 100px; text-align: left">
                    <asp:CheckBoxList ID="chklstVehNo" runat="server" CellPadding="1" CellSpacing="0"
                        DataSourceID="SqlDataSource1" DataTextField="VEHNO" DataValueField="VEH_INTERNAL_NO"
                        Font-Names="Verdana" Font-Size="8pt" RepeatColumns="5" RepeatDirection="Horizontal"
                        Width="650px">
                    </asp:CheckBoxList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AgilityERP_TestConnectionString %>"
                        SelectCommand="SELECT [VEH_INTERNAL_NO], [VEHNO] FROM [webx_VEHICLE_HDR] ORDER BY [VEH_INTERNAL_NO]">
                    </asp:SqlDataSource>
                    </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; text-align: center; height: 24px;">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" />
                                <asp:Button ID="btnCancle" runat="server" Text="Cancle" /></td>
                        </tr>
                    </table>
                </asp:Panel>
                <br />
                <br />
            
</asp:Content> 