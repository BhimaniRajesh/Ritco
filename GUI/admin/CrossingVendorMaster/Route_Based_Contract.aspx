<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Route_Based_Contract.aspx.cs" Inherits="GUI_admin_CrossingVendorMaster_Route_Based_Contract" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="Vendor_Contract.js"></script>
    <script type="text/javascript" language="javascript">
        function checkOnSubmit()
        {        
            var grid =  document.getElementById("ctl00_MyCPH1_GV_Route_Matrix");
            var len=parseInt(grid.rows.length);
            var pref="";
            var cnt=0;
            for(var i=2;i<=len;i++)
            {
                if(i<10)
                    pref = "ctl00_MyCPH1_GV_Route_Matrix_ctl0" + i + "_";
                else
                    pref = "ctl00_MyCPH1_GV_Route_Matrix_ctl"+ i + "_";
                
                var ChkInd = document.getElementById(pref+"ChkInd");
                var Ddl_Mode = document.getElementById(pref+"Ddl_Mode");
                var Ddl_Route = document.getElementById(pref+"Ddl_Route");
                var Ddl_FTL_Type = document.getElementById(pref+"Ddl_FTL_Type");
                var Ddl_Rate_Type = document.getElementById(pref+"Ddl_Rate_Type");
                var Txt_MinChg = document.getElementById(pref+"Txt_MinChg");
                var Txt_MaxChg = document.getElementById(pref+"Txt_MaxChg");
                var Txt_Rate = document.getElementById(pref+"Txt_Rate");
                
                if(ChkInd.checked==true)
                {
                    cnt++;
                    if(Ddl_Mode.value=="")
                    {
                        alert("Please Select From Mode");
                        Ddl_Mode.focus();
                        return false;
                    }                    
                    if(Ddl_Route.value=="")
                    {
                        alert("Please Select Route");
                        Ddl_Route.focus();
                        return false;
                    }
                    if(Ddl_FTL_Type.value=="")
                    {
                        alert("Please Select FTL Type");
                        Ddl_FTL_Type.focus();
                        return false;
                    }
                    if(Txt_MinChg.value=="")
                    {
                        alert("Please Enter Minimum Charge");
                        Txt_MinChg.focus();
                        return false;
                    }
                    if(Txt_MaxChg.value=="")
                    {
                        alert("Please Enter Maximum Charge");
                        Txt_MaxChg.focus();
                        return false;
                    }
                    if(Ddl_Rate_Type.value=="")
                    {
                        alert("Please Select Rate Type");
                        Ddl_Rate_Type.focus();
                        return false;
                    }
                    if(Txt_Rate.value=="")
                    {
                        alert("Please Enter Rate");
                        Txt_Rate.focus();
                        return false;
                    }
                    
                    for(var j=2;j<len;j++)
                    {
                        var jref="";
                        if(j<10)
                            jref = "ctl00_MyCPH1_GV_Route_Matrix_ctl0" + j + "_";
                        else
                            jref = "ctl00_MyCPH1_GV_Route_Matrix_ctl"+ j + "_";   
                        
                        if(i!=j)
                        {
                           var jDdl_Mode = document.getElementById(jref+"Ddl_Mode");
                           var jDdl_Route = document.getElementById(jref+"Ddl_Route");
                           var jDdl_FTL_Type = document.getElementById(jref+"Ddl_FTL_Type");
                           if(jDdl_Mode.value != "" && jDdl_Route.value != "" && jDdl_FTL_Type.value != "")
                           {
                               if(jDdl_Mode.value==Ddl_Mode.value && jDdl_Route.value==Ddl_Route.value && jDdl_FTL_Type.value==Ddl_FTL_Type.value)
                               {
                                    alert("Record Already Exist. Please Select Another Mode, Route or FTL Type");                                    
                                    jDdl_Mode.focus();
                                    return false;
                               }
                           }                            
                        } // i!=j
                        
                    } //  J loop
                
                } // Check of YES/NO        

            } // I loop   
//            if(cnt==0)
//            {
//                alert("No Record Selected To Save.");
//                return false;                    
//            }
//            else
                return true;
        }
    </script>
    <div>
        <asp:UpdatePanel ID="upd1" runat="server">
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <br />
                            <table border="0" style="width: 5.0in" align="left" cellpadding="3" cellspacing="1"
                                class="boxbg">
                                <tr bgcolor="#ffffff">
                                    <td class="bgbluegrey" colspan="2" align="Left">
                                        <font class="bluefnt"><b>Vendor Contract Step 2 : Route Based Contract</b></font>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td colspan="2" align="Left">
                                        <asp:Label ID="Lbl_ADD_Edit" runat="server" CssClass="bluefnt" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td align="Left">
                                        Vendor Type:
                                    </td>
                                    <td align="Left">
                                        <asp:Label ID="Lbl_VendorType" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td align="Left">
                                        Vendor Code & Name:
                                    </td>
                                    <td align="Left">
                                        <asp:Label ID="Lbl_Vendor" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <br />
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                                <ProgressTemplate>
                                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                                        -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                                        <tr>
                                            <td align="right">
                                                <img src="../../images/loading.gif" alt="" /></td>
                                            <td>
                                                <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                                        </tr>
                                    </table>
                                    <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                                        background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                                        opacity: .50; -moz-opacity: .50;" runat="server">
                                        <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                                            left: 50%;" ID="Panel2" runat="server">
                                        </asp:Panel>
                                    </asp:Panel>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <br />
                            <table border="0" style="width: 8.0in" align="left" cellpadding="3" cellspacing="1"
                                class="boxbg">
                                <tr bgcolor="#ffffff">
                                    <td class="bgbluegrey" colspan="2" align="Left">
                                        <font class="bluefnt"><b>Route Based Contract Matrix</b></font>
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td align="Left">
                                        <font class="blackfnt">Enter No. Of Rows</font>
                                    </td>
                                    <td align="Left">
                                        <asp:TextBox ID="Txt_TotRows" runat="server" Text="1" CssClass="blackfnt" BorderStyle="Groove"
                                            Width="60" Style="text-align: right" onkeypress="javascript:return validInt(event)"></asp:TextBox>
                                        <asp:Button ID="Btn_AddRow" OnClick="AddGridRow" runat="server" CssClass="blackfnt"
                                            Text="Add ROW" UseSubmitBehavior="False" />
                                    </td>
                                </tr>
                                <tr bgcolor="#ffffff">
                                    <td align="Left" colspan="2">
                                        <asp:GridView Visible="true" align="left" ID="GV_Route_Matrix" runat="server" BorderWidth="0"
                                            CellPadding="5" CellSpacing="1" HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="false" RowStyle-CssClass="dgRowStyle"
                                            AllowPaging="false" CssClass="boxbg" AutoGenerateColumns="false" FooterStyle-CssClass="boxbg"
                                            OnRowDataBound="GV_Route_Matrix_RowDataBound" EmptyDataText="No Records Found...">
                                            <Columns>
                                                <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white" ItemStyle-Wrap="false">
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="ChkAll" runat="server" onclick="javascript:Check_All('GV_Route_Matrix','ChkAll','ChkInd','N')" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                                            runat="server">
                                                        </asp:Label>
                                                        <asp:CheckBox ID="ChkInd" runat="server" onclick="javascript:Check_Ind('GV_Route_Matrix','ChkAll','ChkInd')" />
                                                        <asp:HiddenField ID="hidID" runat="server" Value="0"/>
                                                    </ItemTemplate>
                                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                    <HeaderStyle CssClass="blackfnt" />
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt"
                                        Font-Bold="true" />
                                    <HeaderTemplate>
                                        Origin
                                    </HeaderTemplate>
                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtlocation" Enabled="false" Visible="false" BorderStyle="groove"
                                            Width="60px" runat="server"></asp:TextBox>
                                        <asp:Button ID="btnorigin" Text="...." runat="server" Visible="false" />
                                        <asp:DropDownList ID="ddlOrigin" runat="server">
                                            <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt"
                                        Font-Bold="true" />
                                    <HeaderTemplate>
                                        Dest.City
                                    </HeaderTemplate>
                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDestcity" Enabled="false" BorderStyle="groove" Width="80px" runat="server"></asp:TextBox>
                                        <asp:Button ID="btnDestination" Text="...." runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt"
                                        Font-Bold="true" />
                                    <HeaderTemplate>
                                        Rate Type
                                    </HeaderTemplate>
                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:DropDownList ID="cmbratetype" runat="server" BackColor="white" CssClass="blackfnt"
                                            onchange="javascript:return checkExist(this.getAttribute('id'))">
                                            <asp:ListItem Value="0">Select</asp:ListItem>
                                            <asp:ListItem Value="K">Per Kg.</asp:ListItem>
                                            <asp:ListItem Value="F">Flat RS</asp:ListItem>
                                            <asp:ListItem Value="P">Per Pkgs</asp:ListItem>
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt"
                                        Font-Bold="true" />
                                    <HeaderTemplate>
                                        Rate
                                    </HeaderTemplate>
                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtrate" BorderStyle="groove" Style="text-align: right;" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                            Width="60px" runat="server" MaxLength="12"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt"
                                        Font-Bold="true" />
                                    <HeaderTemplate>
                                        Door Dely. Charges
                                    </HeaderTemplate>
                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDoorDelyCharge" BorderStyle="groove" Style="text-align: right;"
                                            onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Width="60px"
                                            runat="server" MaxLength="12"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                            </Columns>
                                            <RowStyle HorizontalAlign="center" BackColor="white" CssClass="blackfnt" Wrap="false"
                                                Width="200" />
                                            <PagerStyle HorizontalAlign="left" Font-Bold="true" CssClass="bgbluegrey" />
                                            <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]"
                                                Mode="NumericFirstLast" />
                                            <HeaderStyle Font-Bold="true" CssClass="dgHeaderStyle" HorizontalAlign="Center" VerticalAlign="Middle" Wrap="false" />
                                            <FooterStyle CssClass="boxbg" Wrap="false" Width="200" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="2">
                                        <asp:Button ID="Btn_Submit" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                            Text="Submit Route Based Matrix Data" OnClientClick="javascript:return checkOnSubmit();" OnClick="Submit_Data" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
