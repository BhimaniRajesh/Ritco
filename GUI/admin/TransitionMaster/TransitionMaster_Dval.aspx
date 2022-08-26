
                                                            <asp:TextBox ID="txtAirRate10" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtAirPkg10" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtExpressDay10" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtExpressDist10" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtExpressRate10" runat="server" Width="35px"></asp:TextBox></td>
                                                        <td style="height: 15px">
                                                            <asp:TextBox ID="txtExpressPkg10" runat="server" Width="35px"></asp:TextBox></td>
                                                        </tr>	
	                 </table>
                    <%--</td> 
                   </tr>
				 </table> --%>
               </table> 
               </td> 
          </tr>
          <tr>
          <td align="center">
              <asp:Button ID="btnSubmit" runat="server" OnClientClick="return ValidateData()" OnClick="btnSubmit_Click" Text="Submit" /></td></tr>
           
       </table>
       
        </ContentTemplate>
	</asp:UpdatePanel>  
</asp:Content>
