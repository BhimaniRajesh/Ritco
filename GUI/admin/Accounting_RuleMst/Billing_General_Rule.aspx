<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"  
    CodeFile="Billing_General_Rule.aspx.cs" Inherits="GUI_admin_setting_cust_opn_bal_sel_brnch" %>

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
<font class="blackfnt" c ><b>* <u>NOTE </u>:- Plz Set Proper Rule</b> </font>
<br /><br />
    <table cellspacing="1" cellpadding="5" align="left" border="0" class="boxbg" >
        <tr bgcolor="#FFFFFF">

                    <td   >
                        <table cellspacing="1" cellpadding="5" align="left" border="0" class="boxbg">
           
                            
                        <tr bgcolor="#FFFFFF">
                        <td colspan="2">
                         <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                            <asp:GridView ID="GV_MODULE_RULE" runat="server" AutoGenerateColumns="False" BorderWidth="0px"
                                CellSpacing="1" CssClass="boxbg" EmptyDataText="No Records Found..." FooterStyle-CssClass="boxbg"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast"
                                PagerStyle-HorizontalAlign="left" Width="100%" ShowFooter="false" OnRowDataBound="GV_MODULE_RULE_OnRowDataBound">
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
                                            <asp:Label ID="Lbl_Module_Name" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Module_Name") %>'  ></asp:Label>
                                            <asp:HiddenField ID="Hnd_RULEID" Value='<%# DataBinder.Eval(Container.DataItem, "RULEID") %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Rule Description" >
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="left"  Wrap="false"  />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                            <asp:Label ID="Lbl_RULE_DESC" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "RULE_DESC") %>'  ></asp:Label>
                                            
                                        </ItemTemplate>
                                    </asp:TemplateField>
 
                                   
                                    <asp:TemplateField HeaderText="RULE VALUE">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"  Wrap="false" />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                           <asp:TextBox ID="TXT_RULE_VALUE" runat="server"  Text='<%# DataBinder.Eval(Container.DataItem, "RULE_VALUE") %>'   onblur="javascript:this.value=this.value.toUpperCase()" CssClass="blackfnt" BorderStyle="Groove" ></asp:TextBox>
                                        </ItemTemplate>
                                   </asp:TemplateField>
                                   <asp:TemplateField HeaderText="Narration Accounting Cancel">
                                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="false"  />
                                        <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                         <ItemTemplate>
                                              <asp:CheckBox ID="CHK_RULE_YN"  runat="server" />
                                              <asp:HiddenField ID="Hnd_RULE_YN" Value='<%# DataBinder.Eval(Container.DataItem, "RULE_Y_N") %>' runat="server" />
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
            <td colspan="5" align="center">
                <asp:Button ID="btnSubmit" runat="server"  CssClass="blackfnt"  Text="Submit" OnClick="btnSubmit_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
