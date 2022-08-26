<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="LeaveMasterAdd.aspx.cs" Inherits="GUI_HR_Payroll_Master_LeaveMasterAdd"
    EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
    
    function CheckData(txtAddrows,btnAddrows)
                {
                    if(txtAddrows.value=="")
                        {
                            alert("Please Enter No Of Rows !!!");
                            txtAddrows.focus();
                            return false;
                        }
                        if(txtAddrows.value<0)
                        {
                            alert("Please Enter Posituve Number !!!");
                            txtAddrows.focus();
                            return false;
                        }
                        if(isNaN(txtAddrows.value))
                        {
                            alert("Please Enter Numeric Value !!!");
                            txtAddrows.focus();
                            return false;
                        }
                        
                }
    function Check_txtCode(txt1,txt2,txt3)
         {
         
             var val1 = document.getElementById(txt1);
             var val2 = document.getElementById(txt2);
             var val3 = document.getElementById(txt3);
             
             if(val1.value == "")
                {
                    alert("Please Enter Leave Code")
                    document.getElementById(txt1).focus();
                    return false;
                }
             if(val2.value == "")
                {
                    alert("Please Enter Leave Description")
                    document.getElementById(txt2).focus();
                    return false;
                }
             if(val3.value == "")
                {
                    alert("Please Enter Carry Over Limit")
                    document.getElementById(txt3).focus();
                    return false;
                }
            if(isNaN(val3.value))
                {
                    alert("Please Enter Numeric Value !!!")
                    document.getElementById(txt3).focus();
                    return false;
                }

         }
         
    function Check_txtCode_Update(txt1,txt2,txt3)
         {
         
         var val1 = document.getElementById(txt1);
         var val2 = document.getElementById(txt2);
         var val3 = document.getElementById(txt2);
         
         
         if(val1.value == "")
            {
                alert("Please Enter Leave Code")
                document.getElementById(txt1).focus();
                return false;
            }
         if(val2.value == "")
            {
                alert("Please Enter Leave Description")
                document.getElementById(txt2).focus();
                return false;
            }

            if(val3.value == "")
            {
                alert("Please Enter Carry Over Limit")
                document.getElementById(txt3).focus();
                return false;
            }
            if(isNaN(val3.value))
            {
                alert("Please Enter Numeric Value !!!")
                document.getElementById(txt3).focus();
                return false;
            }
         
         }


function checkcode(obj)
                        { 
                            var a;
                            a=1;
                            obj.value = obj.value.toUpperCase()
                            for(i=0;i<str.length;i++)
                                {
                                if(obj.value==str[i])
                                    {
                                        a=2
                                        alert("Leave Code Already Exist.You can not Enter with this Code...")
                                        obj.focus();
                                        return false
                                    }
                                }
                         }
                       
    </script>

    <br />
    <div align="left">
        <table id="tblAddrows" runat="server" style="width: 9.0in" border="1" cellpadding="0"
            cellspacing="0">
            <tr>
                <td id="tdAddrows" runat="server" align="right">
                    <font class="blackfnt">
                        <asp:Label ID="lblAddrows" runat="server" Text="Add Rows"></asp:Label></font>
                    <asp:TextBox ID="txtAddrows" runat="server" Width="40px" TabIndex="1"></asp:TextBox>
                </td>
                <td align="left">
                    <asp:Button ID="btnAddrows" Width="50px" runat="server" Text="ADD" OnClick="btnAddrows_Click" />
                </td>
            </tr>
        </table>
        <br />
        <asp:UpdatePanel ID="U1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridLeaveType" Style="width: 9.0in" ShowFooter="True" EmptyDataText="No Records Found....."
                    PagerStyle-Mode="NumericPages" AutoGenerateColumns="False" HeaderStyle-CssClass="bgbluegrey"
                    BackColor="White" runat="server" Visible="false" CellSpacing="1" SelectedIndex="1"
                    FooterStyle-HorizontalAlign="Center" OnRowDataBound="GridLeaveType_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.No.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblSrNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Code">
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtCode" runat="server" onBlur="return checkcode(this)"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description">
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Affects Salary">
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:CheckBox ID="ChkAffectSalary" runat="server" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Carry Over">
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:CheckBox ID="chkCarryOver" runat="server" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Carry Over Limit">
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtCarryOverLimit" runat="server"></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:GridView ID="GridView1" Style="width: 9.0in" ShowFooter="True" EmptyDataText="No Records Found....."
                    PagerStyle-Mode="NumericPages" AutoGenerateColumns="False" HeaderStyle-CssClass="bgbluegrey"
                    BackColor="White" runat="server" Visible="false" CellSpacing="1" SelectedIndex="1"
                    FooterStyle-HorizontalAlign="Center" OnRowDataBound="GridView1_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.No.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:Label ID="lblSrNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Code">
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtCode" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"LEAVE_NAME") %>'></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description">
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"LEAVE_DESC") %>'></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Affects Salary">
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:CheckBox ID="ChkAffectSalary" runat="server" /><asp:Label ID="chkdisp1" runat="server"
                                    Text='<%#DataBinder.Eval(Container.DataItem, "AFFECT_SALARY")%>' Visible="false"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Carry Over">
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:CheckBox ID="chkCarryOver" runat="server" /><asp:Label ID="chkdisp2" runat="server"
                                    Text='<%#DataBinder.Eval(Container.DataItem, "CARRY_OVER")%>' Visible="false"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Carry Over Limit">
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <ItemTemplate>
                                <asp:TextBox ID="txtCarryOverLimit" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CARRY_OVER_LIMIT") %>'></asp:TextBox>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:Button ID="btnSubmitGridData" runat="server" Width="60px" Text="Submit" OnClick="btnSubmitGridData_Click" />
</asp:Content>
