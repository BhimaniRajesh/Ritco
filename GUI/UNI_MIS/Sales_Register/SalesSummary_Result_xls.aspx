<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SalesSummary_Result_xls.aspx.cs" Inherits="GUI_UNI_MIS_Sales_Register_SalesSummary_Result" %>


 <br />
                                                            
                                                            <p align="center">
                                                                <label class="blackfnt">
                                                                    <b>
                                                                        You Selected
                                                                    </b>
                                                                </label>
                                                            </p>
                                                            
                                                            <%--<center>--%>
                                                           
                                                            
                                                            <table border="0" cellpadding="3" width="565" style="background-color: #808080;" cellspacing="1" align="center" class="boxbg">
                                                                <tr style="background-color: #ffffff">
                                                                    <td style="height: 10px">
                                                                        Date :</td>
                                                                    <td style="height: 10px">
                                                                        <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                </tr>
                                                                    <tr style="background-color: #FFFFFF">
                                                                        <td style="width: 205; height: 15px;">
                                                                            <label class="blackfnt">
                                                                                RO :</label></td>
                                                                        
                                                                        <td style="width: 343; height: 15px;">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <tr style="background-color: #FFFFFF">
                                                                        <td style="width: 205">
                                                                            <label class="blackfnt">
                                                                                Location :</label></td>
                                                                        
                                                                        <td style="width: 343">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <tr style="background-color: #FFFFFF">
                                                                        <td style="width: 205; height: 6px;">
                                                                            <label class="blackfnt">
                                                                                Customer Code :</label></td>
                                                                        
                                                                        <td style="width: 343; height: 6px;">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblcust" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                               
                                                                </table>
                                                            <br />
<asp:DataGrid ID="dgSales" runat="server"  CellPadding="4"
 HorizontalAlign="Center" 
  HeaderStyle-CssClass = "bgbluegrey"
  ItemStyle-CssClass="blackfnt"
     PagerStyle-Position="Bottom"
    Font-Bold="False" Font-Italic="False" Font-Names="Verdana" Font-Overline="False" Font-Size="Smaller" Font-Strikeout="False" Font-Underline="False" ><Columns> 
 
 
<asp:TemplateColumn HeaderText="Sr No."> 

   <ItemTemplate > 
       <span ><asp:Label ID="lblsrnocomplainlist" text ="<%#Container.DataSetIndex+1 %>" runat="server">
                                 </asp:Label></span> 
   </ItemTemplate>  
   
   
</asp:TemplateColumn> 
    
</Columns> 
                   <FooterStyle CssClass="bgbluegrey" Font-Bold="True" />
                   
                    <ItemStyle CssClass="blackfnt" />
                   

    </asp:DataGrid>
<table cellspacing="1" style="width: 100%">
        <tr align="center">
            <td align="center">
              
               
    

    </td>
        </tr>
    </table>
    
