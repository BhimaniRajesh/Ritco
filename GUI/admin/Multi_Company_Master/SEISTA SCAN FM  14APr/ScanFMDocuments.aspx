<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    EnableViewState="true" CodeFile="ScanFMDocuments.aspx.cs" Inherits="GUI_Operations_FM_ScanFMDocuments"
     %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script language="javascript" type="text/javascript">
function Submitdata()
    {
	    //debugger
	    // alert("HI....")
	    Form_name="ctl00$MyCPH1$"  
        //maxrows=parseInt(document.getElementById(Form_name+"roww").value)
        var rows = document.getElementById("ctl00_MyCPH1_myGrid").rows.length
       
        var maxrows = document.getElementById("ctl00_MyCPH1_myGrid").rows.length
        
        var onecheck=false
		for(i=0;i<rows-1;i++)
        {
            //ctl00$MyCPH1$GV_D$ctl02$txtCityname
            //debugger
            
            j=i+2
            // alert(j)
            if (j<10)
            {
             //alert(document.getElementById("ctl00_MyCPH1_myGrid_ctl0"+j+"_lblScanStatus").value)
                if (document.getElementById("ctl00_MyCPH1_myGrid_ctl0"+j+"_ddlDocType").value == "")
                {
                   alert("Please Select Doc. Type !!!!")
				   document.getElementById("ctl00_MyCPH1_myGrid_ctl0"+j+"_ddlDocType").focus();
				   return false;
                }
                
                if (document.getElementById("ctl00_MyCPH1_myGrid_ctl0"+j+"_txtDocketNo").value == "")
                {
                   alert("Please Enter POD no. !!!!")
				   document.getElementById("ctl00_MyCPH1_myGrid_ctl0"+j+"_txtDocketNo").focus();
				   return false;
                }
                
                if (document.getElementById("ctl00_MyCPH1_myGrid_ctl0"+j+"_fileUpload").value == "")
                {
                   alert("Please File to Upload !!!!")
				   document.getElementById("ctl00_MyCPH1_myGrid_ctl0"+j+"_fileUpload").focus();
				   return false;
                }
            }
            else
            {
            
                //document.getElementById("ctl00_MyCPH1_GV_D_ctl"+j+"_txtCityname").disabled=false
                if (document.getElementById("ctl00_MyCPH1_myGrid_ctl"+j+"_ddlDocType").value == "")
                {
                      alert("Please Select Doc. Type !!!!")
				  document.getElementById("ctl00_MyCPH1_myGrid_ctl"+j+"_ddlDocType").focus();
				   return false;
                }
                
                if (document.getElementById("ctl00_MyCPH1_myGrid_ctl"+j+"_txtDocketNo").value == "")
                {
                   alert("Please Enter POD no. !!!!")
				   document.getElementById("ctl00_MyCPH1_myGrid_ctl"+j+"_txtDocketNo").focus();
				   return false;
                }
                
                if (document.getElementById("ctl00_MyCPH1_myGrid_ctl"+j+"_fileUpload").value == "")
                {
                   alert("Please File to Upload !!!!")
				   document.getElementById("ctl00_MyCPH1_myGrid_ctl"+j+"_fileUpload").focus();
				   return false;
                }                
            }    
        }
	}
    function confirmOnRowChange()
    {
        if(confirm("if you change no of rows, you need to select file again. do you want to continue?"))
        return true;
        
    }
    </script>

    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank" style="border: 0px; position: absolute;
                z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth);
                height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
            </iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please
                    Wait...</b></font></div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table border="0" align="left" cellpadding="0" cellspacing="0" class="blackfnt">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module </strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>Administrator </strong></font><strong>&gt; </strong>
                <font class="blklnkund"><strong>Operations </strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>DFM </strong></font><strong>&gt; </strong>
                <font class="bluefnt"><strong>Scan Documents</strong></font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../images/clear.gif" width="2" height="1" /></td>
        </tr>
        <tr>
            <td>
                <img src="../../images/clear.gif" width="15" height="10" /></td>
        </tr>
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <%--<tr runat="server" id="trFilter">
            <td>
                 <table border="0" cellpadding="0" cellspacing="1" class="boxbg">
                    <tr bgcolor="#ffffff">
                        <td align="right" class="blackfnt">
                            Document Type :
                        </td>
                        <td align="left" valign="middle">                            
                            
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td align="right" class="blackfnt">
                            No of Documents :
                        </td>
                        <td align="left" valign="middle">                            
                            <asp:TextBox ID="txtRows" Width="50px" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="2" valign="middle" align="center">
                            <asp:Button ID="Button1" runat="server" Text="Button" />
                        </td>
                    </tr>
                 </table>
            </td>
        </tr>--%>
        <tr runat="server" id="trDetail">
            <td>
                <table border="0" cellpadding="0" style="width: 9.0in" cellspacing="1" class="boxbg">
                    <tr bgcolor="#ffffff" >
                        <td align="right" style="width: 25%" class="blackfnt">
                            No of Rows :
                        </td>
                        <td align="left" style="width: 25%" valign="middle">
                            <asp:UpdatePanel ID="id2" runat="server" UpdateMode="Always" RenderMode="Inline">
                                <ContentTemplate>
                                    <asp:TextBox ID="txtnorwos" Width="50px" AutoPostBack="true" OnTextChanged="txtnorwos_TextChanged"
                                        runat="server"></asp:TextBox>                                    
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="4" class="blackfnt">
                            <asp:UpdatePanel ID="id1" runat="server" UpdateMode="Always" RenderMode="Inline">
                                <ContentTemplate>
                                    <asp:DataGrid ID="myGrid" runat="server" Width="100%" AutoGenerateColumns="False"
                                        CellPadding="1" CellSpacing="1" GridLines="Both" BorderWidth="0" CssClass="boxbg"
                                        HeaderStyle-CssClass="bgbluegrey" OnItemDataBound="myGrid_ItemDataBound">
                                        <Columns>
                                            <asp:TemplateColumn>
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" />
                                                <HeaderTemplate>
                                                    <asp:Label ID="lblDocTypeHdr" runat="server" Text="Document Type"></asp:Label>
                                                    <br />
                                                    <asp:DropDownList ID="ddlHDocType" runat="server" CssClass="input" Style="margin-left: 1px;"
                                                        AutoPostBack="true" OnSelectedIndexChanged="ddlHDocType_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlDocType" runat="server" CssClass="input" Style="margin-left: 1px;"
                                                        AutoPostBack="true" OnSelectedIndexChanged="ddlDocType_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText=" POD No.">
                                                <FooterStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtDocketNo" OnTextChanged="txtDocketNo_TextChanged" runat="server"
                                                        AutoPostBack="true" CssClass="input"></asp:TextBox>
                                                    <asp:Label class="blackfnt" ID="lblDocketNo" runat="server" Style="color: Red;" Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Document No.">
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtDocNo" runat="server" AutoPostBack="true" CssClass="input"></asp:TextBox>
                                                    <asp:Label ID="lblDocNo" Text=" N/A" runat="server" class="blackfnt" Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Scan Status">
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="lblScanStatus" runat="server" class="blackfnt" Visible="false"></asp:TextBox>
                                                    <asp:Label ID="lblScanStatus_new" runat="server" class="blackfnt" Visible="true"
                                                        Text="Not Scanned"></asp:Label>
                                                    <asp:HyperLink ID="hylView" runat="server" Visible="false" Text="View" Font-Underline="true"
                                                        Target="_blank" CssClass="bluefnt"></asp:HyperLink>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="Select Document">
                                                <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                <ItemTemplate>
                                                    <asp:FileUpload ID="fileUpload" EnableViewState="true" CssClass="input" runat="server" />
                                                    <asp:Label ID="lblUloadLink" runat="server" class="blackfnt" Visible="false" Text="Not Scanned"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                        <ItemStyle BackColor="white" HorizontalAlign="Center" />
                                        <AlternatingItemStyle BackColor="#f7f7f7" HorizontalAlign="Center" />
                                    </asp:DataGrid>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="txtnorwos" EventName="TextChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff">
                        <td colspan="2" align="center">
                            <asp:Button ID="btnSubmit" OnClientClick="return Submitdata()" runat="server" Text="Submit"
                                ToolTip="Click here to complete scan document(s) process" OnClick="btnSubmit_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblMsg" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
