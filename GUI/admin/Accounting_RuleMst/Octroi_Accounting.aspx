<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"  
    CodeFile="octroi_Accounting.aspx.cs" Inherits="GUI_admin_setting_cust_opn_bal_sel_brnch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

  function OnSubmit()
  {
        //alert("hi..")
        var tbl=document.getElementById("ctl00_MyCPH1_GV_PayBaseWise");
        var rows=tbl.rows.length;
        for(i = 2; i < rows ; i++)
        {
           // alert("hi..1")
            if(i<10)
            {
               Cr_Ledger=document.getElementById("ctl00_MyCPH1_GV_PayBaseWise_ctl0" + i + "_DLL_Cr_Ledger");
               Dr_Ledger=document.getElementById("ctl00_MyCPH1_GV_PayBaseWise_ctl0" + i + "_DLL_Dr_Ledger");
               DLL_Instance=document.getElementById("ctl00_MyCPH1_GV_PayBaseWise_ctl0" + i + "_DLL_Instance");
            }
            else
            {
                Cr_Ledger=document.getElementById("ctl00_MyCPH1_GV_PayBaseWise_ctl" + i + "_DLL_Cr_Ledger");
                Dr_Ledger=document.getElementById("ctl00_MyCPH1_GV_PayBaseWise_ctl" + i + "_DLL_Dr_Ledger");
                DLL_Instance=document.getElementById("ctl00_MyCPH1_GV_PayBaseWise_ctl" + i + "_DLL_Instance");
            }
             //alert("hi..2")
            // alert(Cr_Ledger)
            
            if(DLL_Instance.value=="")
            {
                alert("Plz Select Accounting Instance ")
                DLL_Instance.focus()
                return false;
            }
            if(Cr_Ledger.value=="")
            {
                alert("Plz Select Credit From Ledger ")
                Cr_Ledger.focus()
                return false;
            }
            if(Dr_Ledger.value=="")
            {
                alert("Plz Select Debit From Ledger ")
                Dr_Ledger.focus()
                return false;
            }
             
        }
  
  }
 
		
    </script>
<br /><br /><br />
 
    <table cellspacing="1" cellpadding="5" align="left" border="0" class="boxbg" >
    <tr bgcolor="#FFFFFF" align="center">
    <td> <font class="bluefnt"><strong>Sr No</strong></font></td>
    <td> <font class="bluefnt"><strong>Module_Name</strong></font></td>
    <td colspan="3"> <font class="bluefnt"> <strong> Set Octroi Accouting Module Rules</strong> </font></td> </tr>
      <tr bgcolor="#FFFFFF">
                    <td> <font class="blackfnt">1</font></td>
                    <td> <font class="blackfnt">Set Rule For Octroi Customer Bill Generation</font>
                        <asp:HiddenField ID="HiddenField2" runat="server" />
                         <div align="center">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                  <%-- <ProgressTemplate>--%>
                                        <asp:Table ID="Table1" runat="server">
                                        <asp:TableRow>
                                        <asp:TableCell><asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" /></asp:TableCell>
                                        <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
                                        </asp:TableRow>
                                        </asp:Table>
                                     <%--   </ProgressTemplate>                --%>               
                                         </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                    </td>
                    <td colspan="3" >
                        <table cellspacing="1" cellpadding="5" align="left" border="0" class="boxbg">
                            
                          
                        <tr bgcolor="#FFFFFF">
                        <td colspan="2">
                         <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                    <ContentTemplate>
                            <asp:GridView ID="GV_Octroi_bill" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..." FooterStyle-CssClass="boxbg"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast"
                                PagerStyle-HorizontalAlign="left" Width="100%" ShowFooter="false">
                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" />
                                <Columns>
                                   <asp:TemplateField HeaderText="Sr. No.">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="false"  />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:Label ID="lblsrno" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Paybas" >
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="left" Wrap="false"  />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:Label ID="Lbl_Paybas" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Paybas_Desc") %>'  ></asp:Label>
                                            <asp:HiddenField ID="Hnd_paybas" Value='<%# DataBinder.Eval(Container.DataItem, "Paybas_CD") %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Based On Type" >
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="left"  Wrap="false"  />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:Label ID="Lbl_BasedOn_Desc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Basedon_Desc") %>'  ></asp:Label>
                                            <asp:HiddenField ID="Hnd_BasedOn_CD" Value='<%# DataBinder.Eval(Container.DataItem, "Basedon_CD") %>' runat="server" />
                                            <asp:HiddenField ID="OPR_E" Value='<%# DataBinder.Eval(Container.DataItem, "OPR_E") %>' runat="server" />
                                            <asp:HiddenField ID="OPR_C" Value='<%# DataBinder.Eval(Container.DataItem, "OPR_C") %>' runat="server" />
                                            
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Accounting Insatnce">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"  Wrap="false" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:DropDownList ID="DLL_Instance" CssClass="blackfnt" runat="server"></asp:DropDownList> 
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Credit From Ledger">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"  Wrap="false" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:DropDownList ID="DLL_Cr_Ledger" CssClass="blackfnt" runat="server"></asp:DropDownList> 
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                   <asp:TemplateField HeaderText="Debit To Ledger">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"  Wrap="false" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:DropDownList ID="DLL_Dr_Ledger" CssClass="blackfnt" runat="server"></asp:DropDownList> 
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                   
                                    <asp:TemplateField HeaderText="Narration Accounting Entry">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"  Wrap="false" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                           <asp:TextBox ID="Narration_Entry" runat="server"  TextMode="MultiLine" Rows="2" onblur="javascript:this.value=this.value.toUpperCase()" CssClass="Blackfnt" BorderStyle="Groove" ></asp:TextBox>
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                   <asp:TemplateField HeaderText="Narration Accounting Cancel">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="false"  />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                             <asp:TextBox ID="Narration_Cancel" runat="server" TextMode="MultiLine" Rows="2" onblur="javascript:this.value=this.value.toUpperCase()" CssClass="Blackfnt" BorderStyle="Groove" ></asp:TextBox>
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                   
                                   
                                  </Columns>
                                
                                <PagerStyle HorizontalAlign="Left" />
                     </asp:GridView>
                     </ContentTemplate>
                                </asp:UpdatePanel>
                     </td></tr>
                     
                     </table>
                        </td>
         </tr>
  
        <tr bgcolor="#FFFFFF">
                    <td> <font class="blackfnt">2</font></td>
                    <td> <font class="blackfnt">Set Rule For Octroi Customer MR Generation  </font>
                        <asp:HiddenField ID="Hnd_Paybas_Str" runat="server" />
                         <div align="center">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                  <%-- <ProgressTemplate>--%>
                                        <asp:Table ID="Table1" runat="server">
                                        <asp:TableRow>
                                        <asp:TableCell><asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" /></asp:TableCell>
                                        <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
                                        </asp:TableRow>
                                        </asp:Table>
                                     <%--   </ProgressTemplate>                --%>               
                                         </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                    </td>
                    <td colspan="3" >
                        <table cellspacing="1" cellpadding="5" align="left" border="0" class="boxbg">
 
                        <tr bgcolor="#FFFFFF">
                        <td colspan="2">
                         <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                            <asp:GridView ID="GV_Octroi_MR" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..." FooterStyle-CssClass="boxbg"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast"
                                PagerStyle-HorizontalAlign="left" Width="100%" ShowFooter="false">
                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" />
                                <Columns>
                                   <asp:TemplateField HeaderText="Sr. No.">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="false"  />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:Label ID="lblsrno" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Paybas" >
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="left" Wrap="false"  />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:Label ID="Lbl_Paybas" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Paybas_Desc") %>'  ></asp:Label>
                                            <asp:HiddenField ID="Hnd_paybas" Value='<%# DataBinder.Eval(Container.DataItem, "Paybas_CD") %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Based On Type" >
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="left"  Wrap="false"  />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:Label ID="Lbl_BasedOn_Desc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Basedon_Desc") %>'  ></asp:Label>
                                            <asp:HiddenField ID="Hnd_BasedOn_CD" Value='<%# DataBinder.Eval(Container.DataItem, "Basedon_CD") %>' runat="server" />
                                            <asp:HiddenField ID="OPR_E" Value='<%# DataBinder.Eval(Container.DataItem, "OPR_E") %>' runat="server" />
                                            <asp:HiddenField ID="OPR_C" Value='<%# DataBinder.Eval(Container.DataItem, "OPR_C") %>' runat="server" />
                                            
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Accounting Insatnce">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"  Wrap="false" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:DropDownList ID="DLL_Instance" CssClass="blackfnt" runat="server"></asp:DropDownList> 
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Credit From Ledger">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"  Wrap="false" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:DropDownList ID="DLL_Cr_Ledger" CssClass="blackfnt" runat="server"></asp:DropDownList> 
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                   <asp:TemplateField HeaderText="Debit To Ledger">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"  Wrap="false" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:DropDownList ID="DLL_Dr_Ledger" CssClass="blackfnt" runat="server"></asp:DropDownList> 
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                   
                                    <asp:TemplateField HeaderText="Narration Accounting Entry">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"  Wrap="false" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                           <asp:TextBox ID="Narration_Entry" runat="server"  TextMode="MultiLine" Rows="2" onblur="javascript:this.value=this.value.toUpperCase()" CssClass="Blackfnt" BorderStyle="Groove" ></asp:TextBox>
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                   <asp:TemplateField HeaderText="Narration Accounting Cancel">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="false"  />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                             <asp:TextBox ID="Narration_Cancel" runat="server" TextMode="MultiLine" Rows="2" onblur="javascript:this.value=this.value.toUpperCase()" CssClass="Blackfnt" BorderStyle="Groove" ></asp:TextBox>
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                   
                                   
                                  </Columns>
                                
                                <PagerStyle HorizontalAlign="Left" />
                     </asp:GridView>
                     </ContentTemplate>
                                </asp:UpdatePanel>
                     </td></tr>
                     
                     </table>
                        </td>
         </tr>
               <tr bgcolor="#FFFFFF">
        <td><font class="blackfnt">3</font></td>
        <td ><font class="blackfnt">Set Rule For Clerance Charges/Processing Charges/Other Charges/S.Tax Charges Details</font></td>
        <td bgcolor="#FFFFFF">
        <table cellspacing="1" cellpadding="5" align="left" border="0" class="boxbg">
          <tr bgcolor="#FFFFFF">
                     
                    <asp:GridView ID="GV_Accounting_Charges" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..." FooterStyle-CssClass="boxbg"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast"
                                PagerStyle-HorizontalAlign="left" Width="100%" ShowFooter="false">
                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" />
                                <Columns>
                                   <asp:TemplateField HeaderText="Sr. No.">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="false"  />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:Label ID="lblsrno" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Charge Name" >
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="left" Wrap="false"  />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:Label ID="Lbl_Paybas" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Paybas_Desc") %>'  ></asp:Label>
                                            <asp:HiddenField ID="Hnd_paybas" Value='<%# DataBinder.Eval(Container.DataItem, "Paybas_CD") %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Based On Type" >
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="left"  Wrap="false"  />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:Label ID="Lbl_BasedOn_Desc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Basedon_Desc") %>'  ></asp:Label>
                                            <asp:HiddenField ID="Hnd_BasedOn_CD" Value='<%# DataBinder.Eval(Container.DataItem, "Basedon_CD") %>' runat="server" />
                                            <asp:HiddenField ID="OPR_E" Value='<%# DataBinder.Eval(Container.DataItem, "OPR_E") %>' runat="server" />
                                            <asp:HiddenField ID="OPR_C" Value='<%# DataBinder.Eval(Container.DataItem, "OPR_C") %>' runat="server" />
                                            
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Accounting Type">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"  Wrap="false" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:DropDownList ID="DLL_Instance" CssClass="blackfnt" runat="server"></asp:DropDownList> 
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Credit From Ledger">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"  Wrap="false" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:DropDownList ID="DLL_Cr_Ledger" CssClass="blackfnt" runat="server"></asp:DropDownList> 
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                   <asp:TemplateField HeaderText="Debit To Ledger">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"  Wrap="false" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:DropDownList ID="DLL_Dr_Ledger" CssClass="blackfnt" runat="server"></asp:DropDownList> 
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                   
                                    <asp:TemplateField HeaderText="Narration Accounting Entry">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"  Wrap="false" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                           <asp:TextBox ID="Narration_Entry" TextMode="MultiLine" Rows="2" runat="server"  onblur="javascript:this.value=this.value.toUpperCase()" CssClass="Blackfnt" BorderStyle="Groove" ></asp:TextBox>
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                   <asp:TemplateField HeaderText="Narration Accounting Cancel">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="false"  />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                             <asp:TextBox ID="Narration_Cancel" TextMode="MultiLine" Rows="2" runat="server" onblur="javascript:this.value=this.value.toUpperCase()" CssClass="Blackfnt" BorderStyle="Groove" ></asp:TextBox>
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                   
                                   
                                  </Columns>
                                
                                <PagerStyle HorizontalAlign="Left" />
                     </asp:GridView>
          </tr>
           
       
          <tr bgcolor="#FFFFFF">
                    <td> <font class="blackfnt">4</font></td>
                    <td> <font class="blackfnt"><font class="blackfnt">Set Rule For Bill Collection Details</font></font>
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                          
                    </td>
                    <td colspan="3" >
                        <table cellspacing="1" cellpadding="5" align="left" border="0" class="boxbg">
                          
                          
                        <tr bgcolor="#FFFFFF">
                        <td colspan="2">
                         <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                    <ContentTemplate>
                            <asp:GridView ID="GV_BIll_Collection" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..." FooterStyle-CssClass="boxbg"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast"
                                PagerStyle-HorizontalAlign="left" Width="100%" ShowFooter="false">
                                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" />
                                <Columns>
                                   <asp:TemplateField HeaderText="Sr. No.">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="false"  />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:Label ID="lblsrno" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Collection Type" >
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="left" Wrap="false"  />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:Label ID="Lbl_Paybas" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Paybas_Desc") %>'  ></asp:Label>
                                            <asp:HiddenField ID="Hnd_paybas" Value='<%# DataBinder.Eval(Container.DataItem, "Paybas_CD") %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Based On Type" >
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="left"  Wrap="false"  />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:Label ID="Lbl_BasedOn_Desc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Basedon_Desc") %>'  ></asp:Label>
                                            <asp:HiddenField ID="Hnd_BasedOn_CD" Value='<%# DataBinder.Eval(Container.DataItem, "Basedon_CD") %>' runat="server" />
                                            <asp:HiddenField ID="OPR_E" Value='<%# DataBinder.Eval(Container.DataItem, "OPR_E") %>' runat="server" />
                                            <asp:HiddenField ID="OPR_C" Value='<%# DataBinder.Eval(Container.DataItem, "OPR_C") %>' runat="server" />
                                            
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Accounting Insatnce">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"  Wrap="false" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:DropDownList ID="DLL_Instance" CssClass="blackfnt" runat="server"></asp:DropDownList> 
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Credit From Ledger">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"  Wrap="false" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:DropDownList ID="DLL_Cr_Ledger" CssClass="blackfnt" runat="server"></asp:DropDownList> 
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                   <asp:TemplateField HeaderText="Debit To Ledger">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"  Wrap="false" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:DropDownList ID="DLL_Dr_Ledger" CssClass="blackfnt" runat="server"></asp:DropDownList> 
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                   
                                    <asp:TemplateField HeaderText="Narration Accounting Entry">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"  Wrap="false" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                           <asp:TextBox ID="Narration_Entry" runat="server" TextMode="MultiLine" Rows="2" onblur="javascript:this.value=this.value.toUpperCase()" CssClass="Blackfnt" BorderStyle="Groove" ></asp:TextBox>
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                   <asp:TemplateField HeaderText="Narration Accounting Cancel">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="false"  />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                             <asp:TextBox ID="Narration_Cancel" runat="server" TextMode="MultiLine" Rows="2" onblur="javascript:this.value=this.value.toUpperCase()" CssClass="Blackfnt" BorderStyle="Groove" ></asp:TextBox>
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                   
                                   
                                  </Columns>
                                
                                <PagerStyle HorizontalAlign="Left" />
                     </asp:GridView>
                     </ContentTemplate>
                                </asp:UpdatePanel>
                     </td></tr>
                      </table>
        </td>
        
        </tr>
                     </table>
                        </td>
         </tr>      
        <tr bgcolor="#FFFFFF">
            <td colspan="5" align="center">
                <asp:Button ID="btnSubmit" runat="server"  CssClass="blackfnt"  Text="Submit" OnClick="btnSubmit_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
