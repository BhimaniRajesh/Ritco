<%@ Page Language="C#"      MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="VendorBillRegisterResult.aspx.cs" Inherits="GUI_Fleet_Reports_VendorBillReg" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    
    
    
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
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports > Vendor Bill Entry Register</asp:Label>
            </td> 
            
             <td align="right">
         
         
          </td>      
        </tr>
    </table>
    
     <hr align="center" size="1" color="#8ba0e5">
      <br/> 
       <br/> 
        <br/> 
        
        
      <table  align="center" cellspacing="1" style="width: 100%">
            <tr align="center">
                <td  align="center">  
                        
                       <asp:UpdatePanel ID="UpdatePanel2" RenderMode="Inline" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True"  
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            PageSize="100"  OnPageIndexChanging="pgChange" OnRowDataBound="GridView1_RowDataBound" Width="100%"  >
                             <Columns >
                                <asp:BoundField DataField="SR" HeaderText="Sr. No" />
                                 <asp:BoundField DataField="BILLNO" HeaderText="Vendor Bill Entry System Ref No" />
                                 <asp:BoundField DataField="BillENTRYDT" HeaderText="Bill Entry Date" >
                                     <ItemStyle Width="300px" />
                                 </asp:BoundField>
                                  <asp:BoundField DataField="VENDORBILLNO" HeaderText="Manual Bill No" >
                                     <ItemStyle Width="300px" />
                                 </asp:BoundField>
                                 <asp:BoundField DataField="VENDORBILLDT" HeaderText="Manual Bill Date" >
                                     <ItemStyle Width="150px" />
                                 </asp:BoundField>
                                 <asp:BoundField DataField="DUEDT" HeaderText="Due Date" >
                                     <ItemStyle Width="150px" />
                                 </asp:BoundField>
                                 <asp:BoundField DataField="Type_Name" HeaderText="Vendor Type" >
                                 <ItemStyle Width="250px" />
                                 </asp:BoundField>
                                 <asp:BoundField DataField="VENDORNAME" HeaderText="Vendor Name" >
                                  <ItemStyle Width="150px" />
                                 </asp:BoundField>
                                 <asp:BoundField DataField="Company_Acccode" HeaderText="P&L Account Code" />
                                 <asp:BoundField DataField="Accdesc" HeaderText="Expense Head" />
                                 <asp:BoundField DataField="NETAMT" HeaderText="Total Amount" />
                                 <asp:BoundField DataField="PCAMT" HeaderText="Service Tax Applicable Amount" />
                                 
                                 
                                 <asp:BoundField DataField="SVCTAX" HeaderText="Service Tax" />
                                 <asp:BoundField DataField="cessamt" HeaderText="Educations Cess" />
                                 <asp:BoundField DataField="Hedu_cess" HeaderText="Higher Education Cess" />
                                 <asp:BoundField DataField="TDS CATEGORY" HeaderText="TDS CATEGORY">
                                   <ItemStyle Width="250px" />
                                 </asp:BoundField>
                                 <asp:BoundField DataField="TDSRATE" HeaderText="TDS Rate(%ge)" />
                                 <asp:BoundField DataField="TDS" HeaderText="TDS Amount" />
                                 
                                  <asp:BoundField DataField="CashAmt" HeaderText="Cash Amount" />
                                  <asp:BoundField DataField="CHQAMT" HeaderText="Cheque Amount" />
                                  <asp:BoundField DataField="Chqno" HeaderText="Cheque No" />
                                  <asp:BoundField DataField="Chqdate" HeaderText="Cheque Date" />
                                  <asp:BoundField DataField="Payment Date" HeaderText="Payment Date" />
                                  <asp:BoundField DataField="STATUS" HeaderText="Status" />
                                      
                                 
                             </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView> 
                                                         </ContentTemplate>
                           
                          
                           
                                </asp:UpdatePanel>
                
                </td>
                </tr>
                </table>

                
                
                 <table align="center" width="70%">
            <tr align="center">
            <td align="center">
			                <input type="button"       value="  XLS  " runat="server" id="btnXML"   onserverclick="btnXML_Click"/>
			  </td>
			          </tr>
			     </table>
                
                   </asp:Content>