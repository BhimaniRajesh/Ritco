<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="Billentry_step2.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_View_N_Print_Billentry_step2"   EnableEventValidation="false"%>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
        function ViewPrint(arg1,arg2,arg3) 
        { 
            if(arg2!='BA Payment')
            {
            window.open("../PaymentAgainstBillEntry/Vendor/vendorbill_xls.aspx?strGenerateBillNo=" + arg1 + "," + arg3 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"); 
            }
            else
            {
            
            }
            if(arg2 == 'Expense')
            {
            window.open("../ViewExpenseEntry.aspx?expBillNo=" + arg1 + "," + arg3 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"); 
            }
        }
    </script>
<div align="center">

<form id="form1">
    <div align="left">
    
    <p align="left"><font class="blackfnt"><b>You Selected</b></font></p>
    
    <table border="0" cellpadding="3" cols="1" style="width:9.5in" bgcolor="#808080" cellspacing="1" align="left" class="boxbg">
     
      <tr bgcolor="#ffffff"> 
        <td  width="205" align="left"> 
          <div align="left"><font class="blackfnt" >Document Date</font></div>
        </td>
        <td  width="343" align="left"> 
          <div align="left"><font class="blackfnt">
              <asp:Label ID="lblDocDate" runat="server" Text="Label"></asp:Label></font></div>
        </td>
      </tr>
      <tr bgcolor="#ffffff"> 
        <td  width="205" align="left"> 
          <div align="left"><font class="blackfnt">Document Type</font> 
            </div>
        </td>
        <td  width="343" align="center"> 
          <div align="left"><font class="blackfnt">
              <asp:Label ID="lblDocType" runat="server" Text="Label"></asp:Label></font></div>
        </td>
      </tr>
      <%--<tr bgcolor="#ffffff"> 
        <td  width="205" align="left"> 
          <div align="left"><font class="blackfnt">Document No.</font> 
            </div>
        </td>
        <td  width="343" align="center"> 
          <div align="left"><font class="blackfnt">
              <asp:Label ID="lbldocno" runat="server" Text="Label"></asp:Label></font></div>
        </td>
      </tr>--%>
     
    
  </table>
   <br />
   <br />
   <br />
   <br />
   <br />
    
    <p align="left"><font class="blackfnt"><b>Bill Entry List</b></font></p>
    
    
    
                          <br />
                          
                           <%--Data Grid --%>
                           
                           <asp:GridView ID="GridBillList" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
AllowSorting="true" AllowPaging="true" PageSize="25" PagerStyle-HorizontalAlign="left"
CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
 OnPageIndexChanging="pgChange" 
EmptyDataText="No Records Found..." style="width:9.5in">
<Columns >
  <asp:TemplateField>
  <HeaderTemplate >Bill No</HeaderTemplate>
  <HeaderStyle CssClass="blckfnt" HorizontalAlign="Center" />
                <ItemTemplate>
                    <center>
                    <a href="javascript:ViewPrint('<%# DataBinder.Eval(Container.DataItem,"Billno") %>','<%# DataBinder.Eval(Container.DataItem,"Betype") %>','0')"><%# DataBinder.Eval(Container.DataItem,"Billno") %></a>
                    
                    <%--<input type="checkbox" id="chkDock" runat="server" class="input" value='<%# DataBinder.Eval(Container.DataItem,"Billno") %>' />
                 --%> <%--  <asp:CheckBox id="chkDock" runat="server"   />--%>
                    </center>
                </ItemTemplate>
     </asp:TemplateField>




<asp:BoundField DataField="Billno" HeaderText="Bill Number " >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" />
</asp:BoundField>

<asp:BoundField DataField="vendname" HeaderText="Vendor Name " >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
</asp:BoundField>


<asp:BoundField DataField="Location" HeaderText="Bill Location" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
</asp:BoundField>

<asp:BoundField DataField="vendorbilldt" HeaderText="Bill Date" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
</asp:BoundField>

<asp:BoundField DataField="Netamt" HeaderText="Amount" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" HorizontalAlign="right"  />
</asp:BoundField>

<asp:BoundField DataField="Betype" HeaderText="Bill Entry For" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
</asp:BoundField>

 <asp:TemplateField>
  <HeaderTemplate >Print</HeaderTemplate>
  <HeaderStyle CssClass="blckfnt" HorizontalAlign="Center" />
                <ItemTemplate>
                    <center>
                    <a href="javascript:ViewPrint('<%# DataBinder.Eval(Container.DataItem,"Billno") %>','<%# DataBinder.Eval(Container.DataItem,"Betype") %>','1')"><font class="blackfnt">Print</font></a>
                    
                    <%--<input type="checkbox" id="chkDock" runat="server" class="input" value='<%# DataBinder.Eval(Container.DataItem,"Billno") %>' />
                 --%> <%--  <asp:CheckBox id="chkDock" runat="server"   />--%>
                    </center>
                </ItemTemplate>
     </asp:TemplateField>


</Columns>
<PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
<HeaderStyle CssClass="bgbluegrey" />
<PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
/>
<FooterStyle CssClass="boxbg" />
</asp:GridView>

</div>
<br />
 <asp:HiddenField ID="txtdocketlist" runat="server" />
       <asp:HiddenField ID="txtdocketlist_count" runat="server" />
      <div align="left">
 <%--<asp:Button ID="Button1" runat="server"  CssClass="blackfnt" Text="Submit" OnClick="Button1_Click" />--%>
 </div> 
</form>
</div>



</asp:Content>
