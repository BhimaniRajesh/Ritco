<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="vendorContract_Step2.aspx.cs" Inherits="GUI_admin_CrossingVendorMaster_vendorContract_Step2" %>


<asp:Content ID="cntone" runat="server" ContentPlaceHolderID="MyCPH1">
<script src="../../images/commonJs.js"></script>

<script type="text/javascript" language="javascript">




var str_ba_fieldname=""
function validInt(event)
{
    if(event.keyCode==13)
    {
        return true;
    }
    if(event.keyCode<48 || event.keyCode>57)
    {
        event.keyCode=0;return false;
    }
}

 function popuplist(mode,ctlid,tbl)
{
    varTotalRecodrs=0;
    var tblGrid=document.getElementById("ctl00_MyCPH1_grvcity");
    var cmbratetype=ctlid.replace( "txtDestcity", "cmbratetype");
    document.getElementById(cmbratetype).value = "0";
    var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
    var url="";
    url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl ;
    confirmWin=window.open(url,"",winOpts);
    return false;
}
function popupConsignee(mode,ctlid,tbl)
{
    var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
    var url="";
    url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl ;
    confirmWin=window.open(url,"",winOpts);
}
function popupToCity()
	{
	    var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
        var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl + "&tp=0";
            confirmWin=window.open(url,"",winOpts);
            return false;
	}
function checkdata()
{
    var tbl=document.getElementById("ctl00_MyCPH1_grvcity");
    var Totalcount=tbl.rows.length;
    var City_flag = "N";
    for(i = 2; i <= Totalcount ; i++)
    {
        if(i<10)
            {  
               txtDestcity=document.getElementById("ctl00_MyCPH1_grvcity_ctl0" + i + "_txtDestcity");
               cmbratetype=document.getElementById("ctl00_MyCPH1_grvcity_ctl0" + i + "_cmbratetype");
               ddlOrigin=document.getElementById("ctl00_MyCPH1_grvcity_ctl0" + i + "_ddlOrigin");
            }
            else
            {  
               txtDestcity=document.getElementById("ctl00_MyCPH1_grvcity_ctl" + i + "_txtDestcity"); 
               cmbratetype=document.getElementById("ctl00_MyCPH1_grvcity_ctl" + i + "_cmbratetype");
                ddlOrigin=document.getElementById("ctl00_MyCPH1_grvcity_ctl" + i + "_ddlOrigin");
            }
        if(txtDestcity.value != "")
        {
           City_flag = "Y";      
        }
        if(txtDestcity.value != "" && cmbratetype.value == "0")
        {
            alert("Please Select Rate Type");
            cmbratetype.focus();
            return false;         
        }
    }
    for(i = 2; i <= Totalcount ; i++)
        {
           if(i<10)
            {  
               txtDestcity=document.getElementById("ctl00_MyCPH1_grvcity_ctl0" + i + "_txtDestcity");
               cmbratetype=document.getElementById("ctl00_MyCPH1_grvcity_ctl0" + i + "_cmbratetype");
               ddlOrigin=document.getElementById("ctl00_MyCPH1_grvcity_ctl0" + i + "_ddlOrigin");
            }
            else
            {  
               txtDestcity=document.getElementById("ctl00_MyCPH1_grvcity_ctl" + i + "_txtDestcity"); 
               cmbratetype=document.getElementById("ctl00_MyCPH1_grvcity_ctl" + i + "_cmbratetype");
               ddlOrigin=document.getElementById("ctl00_MyCPH1_grvcity_ctl" + i + "_ddlOrigin");
            }
            if(ddlOrigin.value != "0" && txtDestcity.value != "" && cmbratetype.value != "0")
            { 
               for(j = i+1;j <= Totalcount;j++)
               {
                   if(j<10)
                    {  
                        txtDestcity1 = document.getElementById("ctl00_MyCPH1_grvcity_ctl0" + j + "_txtDestcity");
                        cmbratetype1 = document.getElementById("ctl00_MyCPH1_grvcity_ctl0" + j + "_cmbratetype");
                        ddlOrigin1=document.getElementById("ctl00_MyCPH1_grvcity_ctl0" + j + "_ddlOrigin");
                    }
                    else
                    {  
                        txtDestcity1 = document.getElementById("ctl00_MyCPH1_grvcity_ctl" + j + "_txtDestcity"); 
                        cmbratetype1 = document.getElementById("ctl00_MyCPH1_grvcity_ctl" + j + "_cmbratetype");
                        ddlOrigin1=document.getElementById("ctl00_MyCPH1_grvcity_ctl" + j + "_ddlOrigin");
                    }
                    
                    if(ddlOrigin1.value !="0" && txtDestcity1.value != "" && cmbratetype1.value != "0")
                    {   
                        if(ddlOrigin.value == ddlOrigin1.value)
                        {   
                            if(txtDestcity.value == txtDestcity1.value)
                            {
                                if(cmbratetype.value == cmbratetype1.value)
                                {   
                                    alert("Duplicate Rate Type For Same Origin - Deatination......!");
                                    cmbratetype1.value = "0";
                                    cmbratetype1.focus();
                                    return false;
                                }
                            }
                        }
                    }
                }    
             }   
        } 
        if(City_flag == "N")
        {
            alert("Plz Select Atlest One City");
            return false;
        }
}	

function checkExist(cmbratetype)
    {
    //alert(cmbratetype)
        varTotalRecodrs=0;
        var tblGrid=document.getElementById("ctl00_MyCPH1_grvcity");
        TotalRecodrs=tblGrid.rows.length;
        var hdnVendorCode = document.getElementById("ctl00_MyCPH1_hdnVendorCode").value;
        var cmbratetype=cmbratetype;
        var txtDestcity=cmbratetype.replace( "cmbratetype", "txtDestcity");
        var ddlOrigin=cmbratetype.replace( "cmbratetype", "ddlOrigin");
        
        var findobj=false;
                    findobj=GetXMLHttpObject();
                    if(findobj)
                    {
                     var strpg="CheckExist.aspx?origin=" + document.getElementById(ddlOrigin).value + "&destination=" + document.getElementById(txtDestcity).value + "&ratetype=" + document.getElementById(cmbratetype).value + "&VendorCode=" + hdnVendorCode;
                     //alert(strpg);
                     findobj.open("GET",strpg,true);
                     findobj.onreadystatechange=function()
                         {
                         if(findobj.readyState==4 && findobj.status==200)
                                {
                                    var res=findobj.responseText.split("|");
                                    if(res[0]=="false")
                                    {
                                        alert("Selected Data already Exist....");
                                        document.getElementById(cmbratetype).value = "0";
                                        return false;
                                    }
                                    if(res[0]=="true")
                                    {
                                        return true;
                                    }
                                    
                                }
                         }
                         
                    findobj.send(null);
                    }
    }
    

    </script>
    
 <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
            <table bgcolor="#808080" border="0" cellspacing="1" class="boxbg" style="width:10in">
                <tr class="bgbluegrey">
                    <td class="blackfnt" colspan="2">
                            <asp:Label ID="Lbl_ADD_Edit" runat="server" Font-Bold="true"></asp:Label>
                            <asp:HiddenField ID="hdnVendorCode" runat="server" />
                    </td>
                </tr>
                <tr bgcolor="#ffffff">
                    <td class="blackfnt" align="right" >
                        Enter No. of Rows
                    </td>
                    <td class="blackfnt" align="left" >
                        <asp:TextBox runat="server" ID="txtnorows" Width="40px" Style="text-align: right;"
                            BorderStyle="Groove" MaxLength="2" onkeypress="javascript:return validInt(event)"></asp:TextBox>
                        <asp:Button runat="server" Text="Add Rows" CssClass="blackfnt" ID="btnrows" OnClick="btnrows_Click" />
                    </td>
                </tr>
           
                <tr bgcolor="#ffffff">
                    <td class="blackfnt" align="left" colspan="2">
                        <asp:GridView CssClass="boxbg" runat="server" ID="grvcity" CellSpacing="1" Width="99.8%"
                            AllowSorting="true" PagerStyle-HorizontalAlign="left" BorderWidth="0" FooterStyle-CssClass="boxbg"
                            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                            PagerSettings-LastPageText="[Last]"  OnRowDataBound="grvcity_RowDataBound">
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkyes" runat="server" />
                                        <asp:HiddenField ID="hidID" runat="server" Value="0" />
                                         <asp:HiddenField ID="hidContractID" runat="server" Value="0" />
                                    </ItemTemplate>
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
                        </asp:GridView>
                    </td>
                </tr>
                <tr class="bgbluegrey">
                    <td class="blackfnt" align="center" colspan="2">
                        <asp:Button runat="server" Text="Submit" CssClass="blackfnt" ID="btnsubmit" OnClick="btnsubmit_Click"
                            OnClientClick="javascript:return checkdata()"></asp:Button>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
    <asp:HiddenField ID="hdnclient" runat="server" Value="0" />
</asp:Content>
