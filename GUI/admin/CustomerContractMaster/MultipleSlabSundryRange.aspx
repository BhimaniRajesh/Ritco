<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="MultipleSlabSundryRange.aspx.cs" Inherits="GUI_admin_AllTest_MultipleSlabSundryRange"
    Title="Untitled Page" %>
<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo" TagPrefix="cust" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript">
        function btnsubmitClick()
        {
            
            var cnt=0;
                for(var i=1;i<6;i++)
                {
                    var txtIfrom=document.getElementById("ctl00_MyCPH1_txtfrom" + i);
                    var txtIto=document.getElementById("ctl00_MyCPH1_txtto" + i);
                    
                        if(isNaN(txtIfrom.value) || txtIfrom.value=="")
                            txtIfrom.value="0";
                            
                        if(isNaN(txtIto.value) || txtIto.value=="")
                            txtIto.value="0";
                       
                         var cmbIratetype=document.getElementById("ctl00_MyCPH1_cmbratetype" + i);
                         if(cmbIratetype.value!="0")
                         {
                            if(parseInt(txtIto.value)<=parseInt(txtIfrom.value))
                                {
                                    alert("To Value for Slab " + i  + " is less than From Value for Slab " + i);
                                    return false;
                                } 
                                cnt++;   
                         }
                         
                          
                           
                           
                    for(var j=i+1;j<7;j++)
                    {
                        var txtJfrom=document.getElementById("ctl00_MyCPH1_txtfrom" + j);
                        var txtJto=document.getElementById("ctl00_MyCPH1_txtto" + j);
                    
                        if(isNaN(txtJfrom.value) || txtJfrom.value=="")
                            txtJfrom.value="0";
                            
                        if(isNaN(txtJto.value) || txtJto.value=="")
                            txtJto.value="0";
                    
                        var cmbJratetype=document.getElementById("ctl00_MyCPH1_cmbratetype" + j);
                         if(cmbJratetype.value=="0")
                            continue;
                        
                      
                    
                        if(parseInt(txtJfrom.value)<=parseInt(txtIfrom.value) || parseInt(txtJfrom.value)<=parseInt(txtIto.value))
                        {
                            alert("From Value for Slab " + j  + " is less than From Value for Slab " + i);
                            return false;
                        }
                        
                        if(parseInt(txtJto.value)<=parseInt(txtIto.value) || parseInt(txtJto.value)<=parseInt(txtIto.value))
                        {
                            alert("From Value for Slab " + j  + " is less than From Value for Slab " + i);
                            return false;
                        }
                    }
                }
                
                if(cnt==0)
                {
                    alert("Please Select Atleast one Record........");
                    return false;
                }
                
            return true;
        }
    </script>

    <asp:Panel runat="server" Width="10in">
       
       <cust:CustInfo runat="server" ID="cstheader" />
        <asp:Table runat="server" CellSpacing="1" Width="100%" CssClass="boxbg">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="12" Font-Bold="true">
                    Multiple Slab Sundry Slab Range
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                   Slab 1
                </asp:TableCell>
                <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                    Slab 2
                </asp:TableCell>
                <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                   Slab 3
                </asp:TableCell>
                <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                    Slab 4
                </asp:TableCell>
                <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                    Slab 5
                </asp:TableCell>
                <asp:TableCell ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                    Slab 6
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell>From</asp:TableCell>
                <asp:TableCell>To</asp:TableCell>
                <asp:TableCell>From</asp:TableCell>
                <asp:TableCell>To</asp:TableCell>
                <asp:TableCell>From</asp:TableCell>
                <asp:TableCell>To</asp:TableCell>
                <asp:TableCell>From</asp:TableCell>
                <asp:TableCell>To</asp:TableCell>
                <asp:TableCell>From</asp:TableCell>
                <asp:TableCell>To</asp:TableCell>
                <asp:TableCell>From</asp:TableCell>
                <asp:TableCell>To</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell>
                    <asp:TextBox ID="txtfrom1" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                        onkeypress="javascript:return validInt(event)" Style="text-align: right;" MaxLength="8"
                        Width="80px"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtto1" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                        onkeypress="javascript:return validInt(event)" Style="text-align: right;" MaxLength="8"
                        Width="80px"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtfrom2" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                        onkeypress="javascript:return validInt(event)" Style="text-align: right;" MaxLength="8"
                        Width="80px"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtto2" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                        onkeypress="javascript:return validInt(event)" Style="text-align: right;" MaxLength="8"
                        Width="80px"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtfrom3" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                        onkeypress="javascript:return validInt(event)" Style="text-align: right;" MaxLength="8"
                        Width="80px"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtto3" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                        onkeypress="javascript:return validInt(event)" Style="text-align: right;" MaxLength="8"
                        Width="80px"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtfrom4" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                        onkeypress="javascript:return validInt(event)" Style="text-align: right;" MaxLength="8"
                        Width="80px"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtto4" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                        onkeypress="javascript:return validInt(event)" Style="text-align: right;" MaxLength="8"
                        Width="80px"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtfrom5" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                        onkeypress="javascript:return validInt(event)" Style="text-align: right;" MaxLength="8"
                        Width="80px"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtto5" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                        onkeypress="javascript:return validInt(event)" Style="text-align: right;" MaxLength="8"
                        Width="80px"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtfrom6" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                        onkeypress="javascript:return validInt(event)" Style="text-align: right;" MaxLength="8"
                        Width="80px"></asp:TextBox>
                </asp:TableCell>
                <asp:TableCell>
                    <asp:TextBox ID="txtto6" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                        onkeypress="javascript:return validInt(event)" Style="text-align: right;" MaxLength="8"
                        Width="80px"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell ColumnSpan="2">
                    <asp:DropDownList ID="cmbratetype1" runat="server" CssClass="blackfnt" BackColor="white">
                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                        <asp:ListItem Text="perKG" Value="W"></asp:ListItem>
                        <asp:ListItem Text="perPKG" Value="P"></asp:ListItem>
                        <asp:ListItem Text="perTon" Value="T"></asp:ListItem>
                        <asp:ListItem Text="Flat(in RS)" Value="F"></asp:ListItem>
                    </asp:DropDownList>
                </asp:TableCell>
                <asp:TableCell ColumnSpan="2">
                    <asp:DropDownList ID="cmbratetype2" runat="server" CssClass="blackfnt" BackColor="white">
                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                        <asp:ListItem Text="perKG" Value="W"></asp:ListItem>
                        <asp:ListItem Text="perPKG" Value="P"></asp:ListItem>
                        <asp:ListItem Text="perTon" Value="T"></asp:ListItem>
                        <asp:ListItem Text="Flat(in RS)" Value="F"></asp:ListItem>
                    </asp:DropDownList>
                </asp:TableCell>
                <asp:TableCell ColumnSpan="2">
                    <asp:DropDownList ID="cmbratetype3" runat="server" CssClass="blackfnt" BackColor="white">
                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                        <asp:ListItem Text="perKG" Value="W"></asp:ListItem>
                        <asp:ListItem Text="perPKG" Value="P"></asp:ListItem>
                        <asp:ListItem Text="perTon" Value="T"></asp:ListItem>
                        <asp:ListItem Text="Flat(in RS)" Value="F"></asp:ListItem>
                    </asp:DropDownList>
                </asp:TableCell>
                <asp:TableCell ColumnSpan="2">
                    <asp:DropDownList ID="cmbratetype4" runat="server" CssClass="blackfnt" BackColor="white">
                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                        <asp:ListItem Text="perKG" Value="W"></asp:ListItem>
                        <asp:ListItem Text="perPKG" Value="P"></asp:ListItem>
                        <asp:ListItem Text="perTon" Value="T"></asp:ListItem>
                        <asp:ListItem Text="Flat(in RS)" Value="F"></asp:ListItem>
                    </asp:DropDownList>
                </asp:TableCell>
                <asp:TableCell ColumnSpan="2">
                    <asp:DropDownList ID="cmbratetype5" runat="server" CssClass="blackfnt" BackColor="white">
                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                        <asp:ListItem Text="perKG" Value="W"></asp:ListItem>
                        <asp:ListItem Text="perPKG" Value="P"></asp:ListItem>
                        <asp:ListItem Text="perTon" Value="T"></asp:ListItem>
                        <asp:ListItem Text="Flat(in RS)" Value="F"></asp:ListItem>
                    </asp:DropDownList>
                </asp:TableCell>
                <asp:TableCell ColumnSpan="2">
                    <asp:DropDownList ID="cmbratetype6" runat="server" CssClass="blackfnt" BackColor="white">
                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                        <asp:ListItem Text="perKG" Value="W"></asp:ListItem>
                        <asp:ListItem Text="perPKG" Value="P"></asp:ListItem>
                        <asp:ListItem Text="perTon" Value="T"></asp:ListItem>
                        <asp:ListItem Text="Flat(in RS)" Value="F"></asp:ListItem>
                    </asp:DropDownList>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="12">
                    <asp:Button ID="btnsubmit" CssClass="blackfnt" Text="Submit" runat="server" OnClick="btnsubmit_Click"
                        OnClientClick="javascript:return btnsubmitClick()" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:HiddenField ID="hdncontracttype" runat="server" />
        <asp:HiddenField ID="hdncontractid" runat="server" />
        <asp:HiddenField ID="hdncustcode" runat="server" />
        <asp:UpdateProgress ID="uppMain" runat="server">
                <ProgressTemplate>
                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%;
                            left: 40%;" width="190px" cellpadding="0"
                        bgcolor="white">
                        <tr>
                            <td align="right">
                                <img src="../../images/loading.gif" alt="" />
                            </td>
                            <td>
                                <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                            </td>
                        </tr>
                    </table>
                    <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF;
                        width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                        runat="server">
                        <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                            left: 50%;" ID="Panel2" runat="server">
                        </asp:Panel>
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
    </asp:Panel>
</asp:Content>
