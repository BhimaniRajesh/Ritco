<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExpenseVoucher.aspx.cs" MasterPageFile="~/GUI/MasterPage.master" Inherits="GUI_Fleet_Operations_Expense_ExpenseVoucher" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script language="javascript">

function validcheck()
{
  if (document.getElementById('ctl00$MyCPH1$ddlExpVoucherType').value == "")
      {
        alert("Select Expense Voucher Type");
        document.getElementById('ctl00$MyCPH1$ddlExpVoucherType').focus();
        return false;      
      }
  
   if (document.getElementById('ctl00$MyCPH1$ddlExpVoucherType').value == "F")
      {
         var FixedSelFlag=""; 
         if (document.getElementById('ctl00$MyCPH1$chkStat').checked == true)
         {
            FixedSelFlag="T";
         }
         
         if (document.getElementById('ctl00$MyCPH1$chkDriver').checked == true)
         {
            FixedSelFlag="T";
         }
        
         if (document.getElementById('ctl00$MyCPH1$chkVehicleTrack').checked == true)
         {
            FixedSelFlag="T";
         }

         if (document.getElementById('ctl00$MyCPH1$chkFin').checked == true)
         {
            FixedSelFlag="T";
         }
         
         if (FixedSelFlag == "")
         {
            alert("Select atleast one Expense Voucher Head");
            document.getElementById('ctl00$MyCPH1$chkStat').focus();
            return false;   
         }
         
      }
  
  if (document.getElementById('ctl00$MyCPH1$ddlExpVoucherType').value == "V")
  {
    if (document.getElementById('ctl00$MyCPH1$chkRepair').checked == false)
        {
            alert("Please select Repair & Maintenance Expense");
            document.getElementById('ctl00$MyCPH1$chkRepair').focus();
            return false;      
        }
  }
  
      
  //alert("submit");
}

</script>


<asp:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>



<p align="center">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" width="45%">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Expense Voucher</asp:Label>
 
            </td>
            
             <td align=left>
                       
                <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color=red><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  --%>
         
          </td>      
        </tr>
    </table>
    
  
    <hr align="center" size="1" color="#8ba0e5">
      <br/> 
      
      
       <table  align="center" width="80%">
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel10" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
 
                          <table cellspacing="1" cellpadding="3" width="50%" class="boxbg" border="0">
                                <tr style="background-color: white">
                                    <td><font class="blackfnt">Select Expense Voucher type</font></td>
                                    <td >
                                       <asp:DropDownList ID="ddlExpVoucherType" runat=server OnSelectedIndexChanged="ddlExpVoucherType_OnSelectedIndexChange" AutoPostBack=true>
                                        <asp:ListItem Value="" Text="Select"></asp:ListItem>
                                         <asp:ListItem Value="F" Text="Fixed"></asp:ListItem>
                                         <asp:ListItem Value="V" Text="Variable"></asp:ListItem>
                                       </asp:DropDownList>
                                    </td>
                                </tr>
                                
                                 <tr style="background-color: white">
                                    <td valign=top><font class="blackfnt">Select Expense Voucher Heads</font></td>
                                    <td valign=top>
                                        <table id="tblFixedVoucherHeads" visible=false runat=server cellspacing="1" cellpadding="3" width="100%" class="boxbg" border="0">
                                            <tr style="background-color: white">
                                                <td><asp:CheckBox ID="chkStat" runat=server /></td>
                                                <td>Statutory Expense</td>
                                            </tr>
                                            <tr style="background-color: white">
                                                <td><asp:CheckBox ID="chkDriver" runat=server  /></td>
                                                <td>Crew Salary Expense</td>
                                            </tr>
                                             <tr style="background-color: white">
                                                <td><asp:CheckBox ID="chkVehicleTrack" runat=server /></td>
                                                <td>Vehicle Tracking Service Expense</td>
                                            </tr>
                                             <tr style="background-color: white">
                                                <td><asp:CheckBox ID="chkFin" runat=server /></td>
                                                <td>Financial Expense</td>
                                            </tr>
                                           
                                         </table>  
                                         
                                         
                                         <table id="tblVariableVoucherHeads" visible=false runat=server cellspacing="1" cellpadding="3" width="100%" class="boxbg" border="0">
                                             <tr style="background-color: white">
                                                <td><asp:CheckBox ID="chkRepair" runat=server /></td>
                                                <td>Repair & Maintenance Expense</td>
                                            </tr>
                                         </table>    
                                    </td>
                                </tr>
                                <tr style="background-color: white"><td align=center colspan=2><asp:Button ID="btnSubmit" Text="Submit" runat=server OnClick="SubmitData" /></td></tr>
                           </table>
                            
                     </ContentTemplate>
                        <Triggers>
                        </Triggers>
                    </asp:UpdatePanel>                             
                </td>
            </tr>
        </table>        
</asp:Content> 