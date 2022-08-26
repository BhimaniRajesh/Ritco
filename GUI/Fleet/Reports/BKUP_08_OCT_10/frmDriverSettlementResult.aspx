<%@ Page Language="C#"      MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="frmDriverSettlementResult.aspx.cs" Inherits="GUI_Fleet_Reports_TripResult" %>
 
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
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports >Driver Settlement Report</asp:Label>
              <%--  <hr align="center" size="1" color="#8ba0e5"> --%>
            </td> 
            
             <td align="right">
             <%--   <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color="red"><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  --%>
         
         
          </td>      
        </tr>
    </table>
    
     <hr align="center" size="1" color="#8ba0e5">
      <br/> 

      <table  align="left" cellspacing="1" style="width: 100%">
            <tr align="center">
                <td  align="center">  
                        
                       <asp:UpdatePanel ID="UpdatePanel2" RenderMode="Inline" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True"  
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            PageSize="100"  OnPageIndexChanging="pgChange" OnRowDataBound="GridView1_RowDataBound"  >
                             <Columns >
                                 <asp:BoundField DataField="sr" HeaderText="Sr. No" />
                                 <asp:BoundField DataField="VSlipNo" HeaderText="Trip Sheet No" />
                                 <asp:BoundField DataField="VSlipDt" HeaderText="TS Start Date" />
                                 <asp:BoundField DataField="End_dt_tm" HeaderText="TS End Date" />
                                 <asp:BoundField DataField="VehicleNo" HeaderText="Vehicle No." />
                                 <asp:BoundField DataField="Driver_Name" HeaderText="Driver Name" />
                                 <asp:BoundField DataField="LocName" HeaderText="Start Location/ Branch Name" />
                                 <asp:BoundField DataField="End_dt_tm" HeaderText="Financial Close Date" />
                                 <asp:BoundField DataField="DriverSettleDt" HeaderText="Driver Settlement Date" />
                                 <asp:BoundField DataField="TotAdvPaid" HeaderText="Total Advanced Paid" />
                                 <asp:BoundField DataField="TotExpense" HeaderText="Total Expense  (Excluding the fuel exp paid through card)" />
                                 <asp:BoundField DataField="AMTPAYABLE" HeaderText="Amout Payable (+)/ Receivable (-) from Driver" />
                                 <asp:BoundField DataField="AmtRecvdFromDriver" HeaderText="Amount Receivable from Driver" />
                                 <asp:BoundField DataField="AMTRECEIVABLE" HeaderText="Amount Debited to Driver Ledger" />
                                 <asp:BoundField DataField="Status" HeaderText="Status" />
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
                
                
                
                
              <%--   <table align="center" width="70%">
            <tr align="center">
            <td align="center">
			                <input type="button"       value="  XLS  " runat="server" id="btnXML"   onserverclick="btnXML_Click"/>
			  </td>
			          </tr>
			     </table>--%>
                
                   </asp:Content>