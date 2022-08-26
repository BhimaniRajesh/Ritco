<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="FrmDetainedDockets.aspx.cs" Inherits="FrmPaidFollowUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/jscript">
   function checknumber(obj,objchk)
   {
       if (obj.value != "")
       {
            if (isNaN(obj.value))
            {
                alert("Please Enter Numeric Value !!")
                obj.focus()
                return false
            }
            else
            {
                obj.value = parseInt(obj.value)
                return true
            }
       }
       else
       {
            objchk.checked = false;
       }
   }   
   function checkvalid(objtxt,objchk)
   {
        if (objtxt.value == "")
        {
            alert("Please Enter days !!")
            objtxt.focus()
            objchk.checked = false
            return false
        }
   }     
   function checkone()
   {
            var count = 0;
            var rows = document.getElementById("ctl00_MyCPH1_GrdPaidFollow").rows.length;
            for(i=0;i<rows-2;i++)
            {
                j=i+3
                if (j<10)
                {
                    if (document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl0"+j+"_chkselect").checked == true)
                    {
                        count+=1
                    }
                }
                else
                {
                    if (document.getElementById("ctl00_MyCPH1_GrdPaidFollow_ctl"+j+"_chkselect").checked == true)
                    {
                        count+=1
                    }
                }
                
            }
            if (count < 1)
            {
                alert("Please Check Minimum 1 Checkbox !!")
                return false;
            }
            else
            {
                return true;
            }
   }
    </script>

    <%--<table style="width: 319px;height: 173px; z-index: 103; left: 228px; position: absolute; top: 159px;" title="Your Query Here" cellspacing="1" border="1">
      <tr> <td colspan="3" class="bgbluegrey" style="height: 23px">  <p align="center" style="background-color:#d4e0e7"><label class="blackfnt">Your Query Here</label></p>
     </td></tr>
            <tr>
                <td style="width: 319px; text-align: left; height: 25px;" colspan="2">
                    Date Ranges :&nbsp;
                    <asp:Label ID="lbldaterange" runat="server" Style="z-index: 100; left: 115px; position: absolute;
                        top: 40px" Text="Label" Width="197px"></asp:Label>
                    <asp:TextBox ID="TxtDateRange" runat="server" Width="237px" ReadOnly="True" Visible="False" style="z-index: 102; left: 158px; position: absolute; top: 171px"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" style="width: 319px; height: 22px;">
                    RO :
                    <asp:Label ID="lblRO" runat="server" Style="z-index: 100; left: 114px; position: absolute;
                        top: 70px" Text="Label" Width="172px"></asp:Label>
                    <asp:TextBox ID="TxtRO" runat="server" Width="168px" ReadOnly="True" Visible="False" style="z-index: 102; left: 163px; position: absolute; top: 172px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="width: 319px; height: 16px;">
                    Location :
                    <asp:Label ID="lblLocation" runat="server" Style="z-index: 100; left: 115px; position: absolute;
                        top: 100px" Text="Label" Width="173px"></asp:Label>
                    <asp:TextBox ID="txtLocation" runat="server" Width="168px" ReadOnly="True" Visible="False" style="z-index: 102; left: 160px; position: absolute; top: 170px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="width: 319px">
                    Status :&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="Lblstatus" runat="server" Style="z-index: 100; left: 114px; position: absolute;
                        top: 125px" Text="Label" Width="173px"></asp:Label>
                    <asp:Label ID="LblAdviceNO" runat="server" Style="z-index: 100; left: 115px; position: absolute;
                        top: 150px" Text="Label" Width="173px"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="width: 319px">
                    Advice No:</td>
            </tr>
        </table>--%>
    <br />
    <table style="width: 1000px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a href="../../admin/operations.aspx"><font
                        class="blklnkund"><b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>
                            Docket Detention</b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <div align="left">
        <table style="width: 362px; height: 19px" border="0" class="boxbg" cellpadding="5"
            cellspacing="1">
            <tr class="bgbluegrey">
                <td class="blackfnt" colspan="3" align="center" style="height: 19px">
                    Your Query Here
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    Date Range
                </td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="lblDateRange" CssClass="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
            <tr bgcolor="white">
                <td class="blackfnt" align="left">
                    Docket No.</td>
                <td class="blackfnt" align="left">
                    <div align="left">
                        <asp:Label ID="LblAdviceNO" CssClass="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div>
                </td>
            </tr>
        </table>
        <br />
        <asp:TextBox ID="TxtDateRange" runat="server" Width="237px" ReadOnly="True" Visible="False"
            Style="z-index: 102; left: 158px; position: absolute; top: 171px"></asp:TextBox>
        <asp:TextBox ID="TxtFDt" runat="server" Visible="False"></asp:TextBox>
        <asp:TextBox ID="TxtRO" runat="server" Width="168px" ReadOnly="True" Visible="False"
            Style="z-index: 102; left: 163px; position: absolute; top: 172px"></asp:TextBox>
        <asp:TextBox ID="TxtTDt" runat="server" Visible="False"></asp:TextBox><br />
        <asp:TextBox ID="txtLocation" runat="server" Width="168px" ReadOnly="True" Visible="False"
            Style="z-index: 102; left: 160px; position: absolute; top: 170px"></asp:TextBox>
        <asp:GridView ID="GrdPaidFollow" OnPageIndexChanging="PageIndexChanged_Click" PagerStyle-Mode="NumericPages"
            CssClass="boxbg" PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"
            runat="server" OnRowDataBound="GrdPaidFollow_RowDataBound" CellPadding="5" CellSpacing="1"
            BorderWidth="0" OnRowCreated="GrdPaidFollow_RowCreated" EmptyDataText="No Records Found !!"
            EmptyDataRowStyle-CssClass="blackfnt" EmptyDataRowStyle-BackColor="white" Width="978px">
            <Columns>
                <asp:TemplateField HeaderText="SR.NO.">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemStyle BackColor="White" HorizontalAlign="Center" CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>"
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Docket No.">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemStyle BackColor="White" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lbldocketno" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dockno") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Docket Date">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemStyle BackColor="White" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lbldocketdate" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dockdt") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="orgncd" HeaderText="Booking Location">
                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="Delivery Location">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemStyle BackColor="White" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="lbldelloc" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"destcd") %>'
                            runat="server"></asp:Label><br />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Detention Reason">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemStyle BackColor="White" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:DropDownList ID="cmbreason" runat="server" CssClass="blackfnt">
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Detain Days">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemStyle BackColor="White" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:TextBox ID="txtdetaindays" CssClass="blackfnt" runat="server"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Select">
                    <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <ItemStyle BackColor="White" HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:CheckBox ID="chkselect" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <PagerStyle HorizontalAlign="Center" BackColor="White" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" BackColor="White" />
            <EmptyDataRowStyle CssClass="blackfnt" />
        </asp:GridView>
        <asp:LinkButton ID="LinkButton1" runat="server" Visible="false" Font-Bold="True"
            Font-Underline="True" ForeColor="Blue" OnClick="linkexcel" Style="z-index: 101;
            left: 391px; position: absolute; top: 1088px">Excel old</asp:LinkButton>
        &nbsp;&nbsp;&nbsp;<br />
        <br />
        <div align="center" style="width: 978px">
            <asp:Button ID="cmdexcel" runat="server" OnClientClick="return checkone()" OnClick="cmdexcel_Click"
                Text="Submit" Width="54px" Visible="False" />&nbsp;</div>
    </div>
</asp:Content>
