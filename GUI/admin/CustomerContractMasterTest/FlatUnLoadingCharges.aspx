<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="FlatUnLoadingCharges.aspx.cs" Inherits="GUI_admin_CustomerContractMater_FlatMultiPointCharges" %>

<asp:Content runat="server" ContentPlaceHolderID="MyCPH1" ID="cntone">

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript">
    function rowsClick()
    {
        var txtnorows=document.getElementById("ctl00_MyCPH1_txtnorowsftl");
        if(txtnorows.value=="")
        {
            alert("Please Enter No of Rows.......");
            txtnorows.focus();
            return false;
        }
        return true;
    }
    
    function rowsClickSundry()
    {
        var txtnorows=document.getElementById("ctl00_MyCPH1_txtnorowssundry");
        if(txtnorows.value=="")
        {
            alert("Please Enter No of Rows.......");
            txtnorows.focus();
            return false;
        }
        return true;
    }
    function submitClick()
    {
          var grid=document.getElementById("ctl00_MyCPH1_grvunloadingftl");    
          var len=grid.rows.length;
          var i=0;
          var pref="",Jpref="";
 
          len=parseInt(len)+1;
          for(i=2;i<len;i++)
          {
                if(i<10)
                    pref="ctl00_MyCPH1_grvunloadingftl_ctl0" + i + "_";
                else
                    pref="ctl00_MyCPH1_grvunloadingftl_ctl" + i + "_";
                    
                var cmbftltype=document.getElementById(pref + "cmbftltype");
                var txtpickup=document.getElementById(pref + "txtpickup");
                var txtrate=document.getElementById(pref + "txtrate");
                var cmbratetype=document.getElementById(pref + "cmbratetype");
                if(cmbratetype.value=="0" || cmbratetype.value=="")
                {
                    alert("Please Select Rate Type...");
                    cmbratetype.focus();
                    return false;
                }
                
                if(txtrate.value=="")
                    txtrate.value="0.00";
                    
                var j=0;
                for(j=2;j<len;j++)
                {
                    if(j<10)
                        Jpref="ctl00_MyCPH1_grvunloadingftl_ctl0" + j + "_";
                    else
                        Jpref="ctl00_MyCPH1_grvunloadingftl_ctl" + j + "_";
                        
                        var cmbJftltype=document.getElementById(Jpref + "cmbftltype");
                         var cmbJratetype=document.getElementById(Jpref + "cmbratetype");
                        if(i!=j)
                        {
                                if(cmbftltype.value==cmbJftltype.value && cmbratetype.value==cmbJratetype.value )
                                {
                                    alert("No two FTL Type & Rate Trype should be same.......");
                                    cmbJftltype.focus();
                                    return false;
                                }
                        }
                }
          
          }
          
          var gridsundry=document.getElementById("ctl00_MyCPH1_grvunloadingsundry");    
          var lensundry=gridsundry.rows.length;
          lensundry=parseInt(lensundry)+1;
          var i=0,j=0;
          pref=""; Jpref=""
          
          for(i=2;i<lensundry;i++)
          {
                if(i<10)
                    pref="ctl00_MyCPH1_grvunloadingsundry_ctl0" + i + "_";
                else
                    pref="ctl00_MyCPH1_grvunloadingsundry_ctl0" + i + "_";
                
                var txtrate=document.getElementById(pref + "txtrate");
                var cmbratetype=document.getElementById(pref + "cmbratetype");
                
                if(cmbratetype.value=="" || cmbratetype.value=="0")
                {
                     alert("Please Select Rate Type....");
                     cmbratetype.focus();
                     return false;
                }
                
                if(txtrate.value=="")
                    txtrate.value="0.00";
                
                j=0;
                for(j=2;j<lensundry;j++)
                { 
                    if(j<10)
                        Jpref="ctl00_MyCPH1_grvunloadingsundry_ctl0" + j + "_";
                    else
                        Jpref="ctl00_MyCPH1_grvunloadingsundry_ctl0" + j + "_";
                        
                    var cmbJratetype=document.getElementById(Jpref + "cmbratetype");
                    if(i!=j)
                    {
                        if(cmbratetype.value==cmbJratetype.value)
                        {
                            alert("Please Select Different Rate Type....");
                            cmbJratetype.focus();
                            return false;
                        }
                    }
                }
         }
          
          
         return true;   
         
    }
    </script>

    <br />
    <asp:Table ID="Table1" runat="server" CssClass="blackfnt" >
             <asp:TableRow BackColor="White">
                <asp:TableCell>
				       &nbsp;ContractID  
                </asp:TableCell>
                <asp:TableCell>
                     : <asp:Label ID="lblcontractid" runat="server" onmouseover="this.style.cursor='pointer'" CssClass="redfnt" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
                         <asp:TableRow BackColor="White">
                <asp:TableCell>
				       &nbsp;Customer Code & Name &nbsp;
                </asp:TableCell>
                <asp:TableCell>
                : <asp:Label ID="lblcustcodename" runat="server" onmouseover="this.style.cursor='pointer'" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table> 
    <br />
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
    <asp:UpdatePanel runat="server" ID="updone">
        <ContentTemplate>
            <asp:Panel runat="server" Width="10in">
                <asp:Table runat="server" ID="tblftlcapacity" Width="100%" CellSpacing="1" CellPadding="1"
                    BorderWidth="0" CssClass="boxbg">
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell HorizontalAlign="Center" ColumnSpan="2" Font-Bold="true">
                                Flat UnLoading Charges - Sundry
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow BackColor="White">
                        <asp:TableCell HorizontalAlign="Right" Width="50%">
                        Enter No of Rows
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtnorowssundry" runat="server" BorderStyle="Groove" Style="text-align: right;"
                                Width="40px" CssClass="blackfnt" onkeypress="javascript:return validInt(event)"
                                MaxLength="3">
                            </asp:TextBox>
                            <asp:Button ID="btnaddrowssundry" runat="server" CssClass="blackfnt" OnClick="btnaddrowssundry_Click"
                                OnClientClick="javascript:return rowsClickSundry()" Text="Add Rows" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow BackColor="White">
                        <asp:TableCell ColumnSpan="2">
                            <asp:GridView HorizontalAlign="center" ID="grvunloadingsundry" runat="server" BorderWidth="0"
                                CellSpacing="1" AllowSorting="true" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                BackColor="#8ba0e5" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="<%=boxbg%>"
                                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" OnRowDataBound="grvunloadingsundry_RowDataBound"
                                EmptyDataText="No Records Found..." Style="width: 100%;">
                                <Columns>
                                    <asp:TemplateField HeaderText="Rate Type" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                        <ItemStyle BackColor="White" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="cmbratetype" runat="server" BackColor="White" DataTextField="codedesc"
                                                DataValueField="codeid" CssClass="blackfnt">
                                                <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="PerKG" Value="W"></asp:ListItem>
                                                <asp:ListItem Text="PerPKG" Value="P"></asp:ListItem>
                                                <asp:ListItem Text="PerTon" Value="T"></asp:ListItem>
                                                <asp:ListItem Text="Flat" Value="F"></asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Charge Rate" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                        <ItemStyle BackColor="White" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate" runat="server" BorderStyle="Groove" Style="text-align: right;"
                                                Width="100px" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"rate") %>'
                                                onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" onblur="javascript:return this.value=roundNumber(this.value,2)"
                                                MaxLength="12">
                                            </asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell Font-Bold="true" HorizontalAlign="Center" ColumnSpan="2">
                    Flat UnLoading Charges - FTL
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow BackColor="White">
                        <asp:TableCell HorizontalAlign="Right" Width="50%">
                        Enter No of Rows
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtnorows" runat="server" BorderStyle="Groove" Style="text-align: right;"
                                Width="40px" CssClass="blackfnt" onkeypress="javascript:return validInt(event)"
                                MaxLength="3">
                            </asp:TextBox>
                            <asp:Button ID="btnaddrows" runat="server" CssClass="blackfnt" OnClick="btnaddrows_Click"
                                OnClientClick="javascript:return rowsClick()" Text="Add Rows" />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow BackColor="White">
                        <asp:TableCell ColumnSpan="2">
                            <asp:GridView HorizontalAlign="center" ID="grvunloadingftl" runat="server" BorderWidth="0"
                                CellSpacing="1" AllowSorting="true" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                BackColor="#8ba0e5" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="<%=boxbg%>"
                                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" OnRowDataBound="grvunloadingftl_RowDataBound"
                                EmptyDataText="No Records Found..." Style="width: 100%;">
                                <Columns>
                                    <asp:TemplateField HeaderText="FTL Type Name" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                        <ItemStyle BackColor="White" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="cmbftltype" BackColor="White" runat="server" DataTextField="codedesc"
                                                DataValueField="codeid" CssClass="blackfnt">
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Rate Type" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                        <ItemStyle BackColor="White" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="cmbratetype" runat="server" BackColor="White" DataTextField="codedesc"
                                                DataValueField="codeid" CssClass="blackfnt">
                                                <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                                <asp:ListItem Text="PerKG" Value="W"></asp:ListItem>
                                                <asp:ListItem Text="PerPKG" Value="P"></asp:ListItem>
                                                <asp:ListItem Text="PerTon" Value="T"></asp:ListItem>
                                                <asp:ListItem Text="Flat" Value="F"></asp:ListItem>
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Charge Rate" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                        <ItemStyle BackColor="White" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtrate" runat="server" BorderStyle="Groove" Style="text-align: right;"
                                                Width="100px" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"rate") %>'
                                                onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" onblur="javascript:return this.value=roundNumber(this.value,2)"
                                                MaxLength="12">
                                            </asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow CssClass="bgbluegrey">
                        <asp:TableCell HorizontalAlign="Center" ColumnSpan="2">
                            <asp:Button ID="btnsubmit" runat="server" OnClientClick="javascript:return submitClick()"
                                OnClick="btnsubmit_Click" CssClass="blackfnt" Text="Submit" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
