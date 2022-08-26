<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="StepSelection.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_StepSelection" %>
<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo" TagPrefix="cust" %>

<asp:Content ID="cntone" ContentPlaceHolderID="MyCPH1" runat="server">
    <cust:CustInfo runat="server" ID="cstheader" />
    <br />
    <script type="text/javascript" language="javascript">
        function submitClick()
        {
            var optintro = document.getElementById("ctl00_MyCPH1_optintro");
            var optservices =document.getElementById("ctl00_MyCPH1_optservices");
            var optcharges =document.getElementById("ctl00_MyCPH1_optcharges");
            
            var optsundry =document.getElementById("ctl00_MyCPH1_optsundry");
            var optftl =document.getElementById("ctl00_MyCPH1_optftl");
            var optoda =document.getElementById("ctl00_MyCPH1_optoda");
            
            var optflatmultipoint =document.getElementById("ctl00_MyCPH1_optflatmultipoint");
            var optlocmultipoint =document.getElementById("ctl00_MyCPH1_optlocmultipoint");
            
            var optflatloading =document.getElementById("ctl00_MyCPH1_optflatloading");
            var optlocloading =document.getElementById("ctl00_MyCPH1_optlocloading");
            
            var optflatunloading =document.getElementById("ctl00_MyCPH1_optflatunloading");
            var optlocunloading =document.getElementById("ctl00_MyCPH1_optlocunloading");
            
                        
            var cnt=0;
            
            if(optintro.checked==true)
                cnt++;               
            
            if(optservices.checked==true)
                cnt++;

            if(optcharges.checked==true)
                cnt++;                   
                
            if(optsundry.checked==true)
                cnt++;               
            
            if(optftl.checked==true)
                cnt++;
           
           if(optoda.checked==true)
                cnt++;
           
           if(optflatmultipoint.checked==true)
                cnt++;
           
           if(optlocmultipoint.checked==true)
                cnt++;
           
           if(optflatloading.checked==true)
                cnt++;
           
           if(optlocloading.checked==true)
                cnt++;
           
           if(optflatunloading.checked==true)
                cnt++;
           
           if(optlocunloading.checked==true)
                cnt++;
           
                    
           if(cnt==0)
           {
                alert("Please Select any One Option");
                return false;
           }
           
            return true;
        }
    </script>
    <asp:Panel runat="server" Width="10in" HorizontalAlign="Center">
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
        <asp:Table Width="5in" runat="server" CssClass="boxbg" CellPadding="0" CellSpacing="1"
            BorderWidth="0">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="2" HorizontalAlign="Left" Font-Bold="true">
            &nbsp;Select Step
                </asp:TableCell>
            </asp:TableRow>
             <asp:TableRow ID="trintro" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optintro" runat="server" GroupName="grvchoose"
                        CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Contract Basic Information
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trservices" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optservices" runat="server" GroupName="grvchoose"
                        CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Service Selection
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trcharges" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optcharges" runat="server" GroupName="grvchoose"
                        CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Other Charges
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trsundry" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optsundry" runat="server" GroupName="grvchoose"
                        CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Freight Charges - Sundry
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trftl" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optftl" runat="server" GroupName="grvchoose" CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Freight Charges - FTL
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="troda" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optoda" runat="server" GroupName="grvchoose" CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;ODA Charges
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trflatmultipoint" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optflatmultipoint" runat="server" GroupName="grvchoose" CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Flat MultiPoint Charges
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trflatloading" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optflatloading" runat="server" GroupName="grvchoose" CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Flat Loading Charges 
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trflatunloading" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optflatunloading" runat="server" GroupName="grvchoose" CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Flat UnLoading Charges 
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trlocmultipoint" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optlocmultipoint" runat="server" GroupName="grvchoose" CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Location Wise MultiPoint Charges
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trlocloading" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optlocloading" runat="server" GroupName="grvchoose" CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Location Wise Loading Charges 
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trlocunloading" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optlocunloading" runat="server" GroupName="grvchoose" CssClass="blackfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Location Wise UnLoading Charges 
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trsubmit" runat="server" CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="Center" ColumnSpan="2">
                    <asp:Button ID="btnSubmit" CssClass="blackfnt" Text="Submit" runat="server" ToolTip="Click here to submit and proceed"
                        OnClientClick="javascript:return submitClick()" OnClick="btnSubmit_Click" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
</asp:Content>
