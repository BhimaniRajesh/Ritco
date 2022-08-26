<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
  EnableEventValidation="false"  CodeFile="Login_2_2.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b> <font class="blklnkund"><b>Special
                        Reports</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Login View Report</b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <div align="center" style="width: 7in">
        <table border="0" align="center" width="365"  cellspacing="1" cellpadding="5"
            class="boxbg">
            <tr align="left" style="background-color: #ffffff">
                <td style="height: 10px">
                    <label class="blackfnt">
                        Date :
                    </label>
                    <asp:Label ID="Label1" runat="server" Visible="false"></asp:Label>
                </td>
                <td style="height: 10px">
                    <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
            </tr>
            <tr align="left" style="background-color: #FFFFFF">
                <td style="width: 205">
                    <label class="blackfnt">
                        Location :</label></td>
                <td style="width: 343">
                    &nbsp;
                    <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            <tr align="left" style="background-color: #FFFFFF">
                <td style="width: 205; height: 6px;">
                    <label class="blackfnt">
                        Employee :</label></td>
                <td style="width: 343; height: 6px;">
                    &nbsp;
                    <asp:Label ID="lblemp" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            <tr align="left" style="background-color: #ffffff">
                <td style="height: 6px">
                    <label class="blackfnt">
                        Login Instance &gt;=
                    </label>
                </td>
                <td style="height: 6px">
                    &nbsp;
                    <asp:Label ID="lblli" runat="server" CssClass="blackfnt">
                    </asp:Label>
                </td>
            </tr>
        </table>
        <%--<asp:UpdatePanel ID="UP1" runat="Server">
                 
           
                                                                    <ContentTemplate>--%>
        <br />
        <br />
    </div>
    <div align="left" style="width: 11in">
        <table border="0" width="95%" style="background-color: #808080;" align="center" class="boxbg">
            <tr style="background-color: #ffffff">
                <td style="height: 10px">
                    <asp:GridView ID="GV_D" runat="server" align="left" BorderWidth="0" CellPadding="5" CellSpacing="1"
                        HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                          FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
                        OnPageIndexChanging="pgChange" AllowSorting="False" AutoGenerateColumns="false"
                        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                        <PagerStyle VerticalAlign="Bottom" />
                        <Columns>
                            <asp:BoundField DataField="SRNO" HeaderText="Sr.No">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="emp" HeaderText="Employee">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white"  CssClass="blackfnt" />
                            </asp:BoundField>
                            <asp:BoundField DataField="loc" HeaderText="Location">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt"  BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="login" HeaderText="Login Time ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle HorizontalAlign="Center" BackColor="white"  CssClass="blackfnt" />
                            </asp:BoundField>
                            <asp:BoundField DataField="logout" HeaderText="Logout Time ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" BackColor="white"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="duration" HeaderText="duration (Minutes)">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center"  BackColor="white" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                </td>
                <%-- </ContentTemplate>
                                                                </asp:UpdatePanel>--%>
            </tr>
            <tr align="center" style="background-color: #ffffff">
                <td>
                    <asp:GridView ID="GV_S" runat="server" Width="800" align="center" BorderWidth="1"
                        CellPadding="2" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                        CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg" AllowPaging="true"
                        PageSize="25" AutoGenerateColumns="false" OnPageIndexChanging="pgChange" AllowSorting="False"
                        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                        <PagerStyle VerticalAlign="Bottom" />
                        <Columns>
                            <asp:BoundField DataField="EMPCD" HeaderText="Employee Code">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle HorizontalAlign="Center" CssClass="blackfnt" />
                            </asp:BoundField>
                            <asp:BoundField DataField="EMPNM" HeaderText="Employe Name">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NOOFLOGIN" HeaderText="No. Of Times Login">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="To be collected Rs. ** ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <a href="Login_2_2.aspx?strDateRange=" +'<%#Request.QueryString["strDateRange"]%>'+ "&strloc=" + '' + "&stremp=" +'<%# DataBinder.Eval(Container.DataItem, "EMPCD")%>'  + "&strlogininstence=" + "" + "&strlogininstence="+"">
                                        <%--<asp:HyperLink  Font-Underline="True"  ForeColor="#000099"  Runat="server"  NavigateUrl='<%#"DetailFlow.aspx?loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&rep="+"2"+"&repdate="+Request.QueryString["DOCDate"].ToString()+"&custcd="+Request.QueryString["Cust"].ToString()+"&dttype="+Request.QueryString["DateType"].ToString()+"&flow="+Request.QueryString["Flow"].ToString()%>' Text= '<%#DataBinder.Eval(Container.DataItem, "LEFT_TOTDKTS")%>' ID="Hyperlink2"/>
--%>
                                        <%#DataBinder.Eval(Container.DataItem, "NOOFLOGIN")%>
                                        <font cssclass="Blackfnt"></a>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr style="background-color: #ffffff" >
            <td >
                <asp:Label ID="lblnull" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Medium"
                    ForeColor="Red" Text="Label" Visible="False"></asp:Label></td>
            </tr>
        </table>
        <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                                                                    <ContentTemplate>--%>
        <br />
        <br />
       
        <div style="width:8in">
        <table border="0" cellpadding="0" width="365" cellspacing="0" align="center">
            <tr align="center">
                <td style="background-color: #ffffff">
                    <asp:LinkButton ID="LinkButton1" OnClick="fst" runat="server" Text="First">
                    </asp:LinkButton>
                </td>
                <td style="background-color: #ffffff">
                    <asp:LinkButton ID="LinkButton2" OnClick="lst" runat="server" Text="Last">
                    </asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="background-color: #ffffff" align="center">  <br />
        
                    <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
        </table>
        </div>
    </div>
</asp:Content>
