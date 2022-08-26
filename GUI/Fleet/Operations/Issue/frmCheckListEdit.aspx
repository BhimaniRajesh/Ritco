<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="frmCheckListEdit.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_frmCheckListEdit"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript">
function createXMLHttpRequest()
{
    // Mozilla, Safari,...
    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
    // IE
    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
}

function CheckValidChecklist(tb_Description)
{
    var currentTime = new Date();
    var lbl_Desc_Err = document.getElementById("ctl00_MyCPH1_lbl_Desc_Err");
    var ddl_Category = document.getElementById("ctl00_MyCPH1_ddl_Category");
    var hfId = document.getElementById("ctl00_MyCPH1_hfId");
    
    if(tb_Description.value == "")
    {
        tb_Description.value="";
        return;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest)
    {
        xmlHttpRequest.onreadystatechange = function()
        {
            if (xmlHttpRequest.readyState == 4)
            {
                var returnValue=xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") 
                {
                    tb_Description.style.borderColor="";
                    tb_Description.value=tb_Description.value;
                    lbl_Desc_Err.innerText = "";
                }
                else
                {
                    lbl_Desc_Err.innerText = "Already Exist !! ";
                    tb_Description.style.borderColor="red";
                    tb_Description.focus();
                    return false;
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidCheckList&datetime="+currentTime+"&Chk_ID="+hfId.value+"&Chk_Cat="+ddl_Category.value+"&Chk_Desc="+ tb_Description.value, false);
        xmlHttpRequest.send(null);
    }
}

function CheckValidataion()
{
    var ddl_Category = document.getElementById("ctl00_MyCPH1_ddl_Category");
    var tb_Description = document.getElementById("ctl00_MyCPH1_tb_Description");
    var lst_Document = document.getElementById("ctl00_MyCPH1_lst_Document");
    
    if(ddl_Category.value == "0" )
    {
       alert("Select Category!!!");
       ddl_Category.focus();
       //document.getElementById(pref + "txtTo").focus();
       return false;
    }
    
    if(tb_Description.value == "" )
    {
        alert("Enter Checklist Description")
        tb_Description.focus();
        //document.getElementById(pref + "txtFrom").focus();
        return false;
    }
    
    if(lst_Document.value == "")
    {
        alert("Select Document To be Shown");
        lst_Document.focus();
        //document.getElementById(pref + "txtStartDate").focus();
        return false;
    }        
}

    </script>

    <%--<asp:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>--%>
    <div align="left">
        <table cellspacing="1" style="width: 800px">
            <tr style="background-color: white">
                <td align="left">
                    <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Sheet >> CheckList Module </asp:Label>
                </td>
                <td align="right">
                </td>
            </tr>
            <tr class="bgbluegrey">
                <td class="blackfnt" colspan="3" style="text-align: Center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="CHECKLIST"></asp:Label>
                </td>
            </tr>
            <tr style="background-color: white">
                <td class="blackfnt" colspan="3" style="text-align: Center">
                    <asp:Label ID="lblError" runat="server" CssClass="redfnt" Font-Bold="true"></asp:Label>
                    <asp:HiddenField ID="hfTodayDate" Value="" runat="server" />
                </td>
            </tr>
        </table>
        <br/>
        <hr/>
        <br/>
        <asp:UpdatePanel ID="u1" runat="server" UpdateMode="Always" RenderMode="Inline">
            <ContentTemplate>
                <table id="tb_add" border="0" class="boxbg" cellpadding="1" cellspacing="1" border="1"
                    width="800">
                    <tr id="Tr1" runat="server" class="bgbluegrey">
                        <td align="center" class="blackfnt" style="font-weight: bold; font-size: 8pt; width: 10%;
                            color: white; font-family: Verdana; height: 17px">
                            <asp:LinkButton ID="lnk_btn_Add" runat="server" CausesValidation="False"
                                OnClick="lnk_btn_Add_Click" Text="Add New" Visible="true"></asp:LinkButton>
                        </td>
                        <td align="center" class="blackfnt" style="font-weight: bold; font-size: 8pt; width: 15%;
                            font-family: Verdana; height: 17px">
                            Category
                        </td>
                        <td align="center" class="blackfnt" style="font-weight: bold; font-size: 8pt; width: 30%;
                            font-family: Verdana; height: 17px">
                            Checklist Description
                        </td>
                        <td align="center" class="blackfnt" style="font-weight: bold; font-size: 8pt; width: 35%;
                            font-family: Verdana; height: 17px">
                            Document To be Shown
                        </td>
                        <td align="center" class="blackfnt" style="font-weight: bold; font-size: 8pt; width: 10%; 
                            font-family: Verdana; height: 17px">
                            Active
                        </td>
                    </tr>
                    <tr id="RowNo" runat="server" class="bglightblue">
                        <td align="left" class="blackfnt" >
                            <asp:LinkButton ID="btn_Submit" runat="server" OnClick="btn_Submit_Click" OnClientClick="javascript:return CheckValidataion()">Save</asp:LinkButton>
                            ||
                            <asp:LinkButton ID="btn_Cancel" runat="server" OnClick="btn_Cencel_Click">Cancel</asp:LinkButton>
                        </td>
                        <td align="left" class="blackfnt">
                            <asp:DropDownList ID="ddl_Category" runat="server" BorderStyle="Groove" />
                            <font class="blackfnt" color="red">*</font>
                            <asp:Label ID="lbl_Category_Err" runat="server" Text="" Style="font-size: 8pt; color: red;
                                font-family: Verdana"></asp:Label>
                            <asp:HiddenField ID="hfId" runat="server" />
                        </td>
                        <td class="blackfnt" >
                            <asp:TextBox CssClass="input" ID="tb_Description" Width="200px" TextMode="MultiLine"
                                runat="server" BorderStyle="Groove"></asp:TextBox>
                                <font class="blackfnt" color="red">*</font>
                            <asp:Label ID="lbl_Desc_Err" runat="server" Text="" Style="font-size: 8pt; color: red;
                                font-family: Verdana"></asp:Label>
                        </td>
                        <td class="blackfnt" >
                            <asp:ListBox ID="lst_Document" runat="server" BorderStyle="Groove" SelectionMode="Multiple"
                                CssClass="input" Width="150px" Height="50px" ></asp:ListBox>
                                <font class="blackfnt" color="red">*</font>
                        </td>
                        <td class="blackfnt" align="center" >
                            <asp:CheckBox ID="chk_Active_Flag" runat="server" />
                        </td>
                    </tr>
                </table>
                <table id="Table1" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="800">
                    <tr bgcolor="white">
                        <td class="blackfnt" colspan="3" style="text-align: right">
                            <asp:GridView ID="gvChecklist" runat="server" BackColor="White" BorderColor="#CCCCCC"
                                BorderStyle="None" BorderWidth="1px" CellPadding="3" Width="100%" AutoGenerateColumns="False"
                                ShowFooter="false" ShowHeader="false" OnRowDataBound="gvChecklist_RowDataBound"
                                OnSelectedIndexChanged="gvChecklist_SelectedIndexChanged" OnPageIndexChanging="gvChecklist_PageIndexChanging"
                                CssClass="blackfnt">
                                <RowStyle ForeColor="#000066" />
                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                <SelectedRowStyle CssClass="bglightblue" Font-Bold="True" ForeColor="black" />
                                <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                                Text="Edit"></asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle Width="10%" HorizontalAlign="Left" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Category">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_Category" runat="server" Text='<%# Bind("Chk_Cat_name") %>'></asp:Label>
                                            <asp:HiddenField ID="hfId" runat="server" Value='<%# Bind("Chk_ID") %>' />
                                            <asp:HiddenField ID="hfcatcode" runat="server" Value='<%# Bind("Chk_Cat") %>' />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" Width="15%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Checklist Description">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_Description" runat="server" Text='<%# Bind("Chk_Desc") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left"  Width="30%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Document To be Shown">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_Document" runat="server" Text='<%# Bind("Chk_Document_Shown_name") %>'></asp:Label>
                                            <asp:HiddenField ID="hfdoccode" runat="server" Value='<%# Bind("Chk_Document_Shown") %>' />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left"  Width="35%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Active">
                                        <ItemTemplate>
                                            <asp:Label ID="lbl_Active_Flag" runat="server" Text='<%# Bind("ActiveFlag") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center"  Width="10%" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle ForeColor="Black" Font-Bold="False" Font-Italic="False" Font-Size="8pt"
                                    CssClass="bgbluegrey" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
                <tr bgcolor="white">
                    <td class="blackfnt" colspan="3" style="vertical-align: middle; text-align: center;
                        height: 25px;">
                        <asp:Label ID="lblError1" runat="server" CssClass="redfnt" Font-Bold="true"></asp:Label>
                </tr>
              
                <tr bgcolor="white" align="center">
                <font class="blackfnt" style="color:Red;">
                    <b><asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Small" Text=""></asp:Label></b>
                </font>
                </tr>

            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
