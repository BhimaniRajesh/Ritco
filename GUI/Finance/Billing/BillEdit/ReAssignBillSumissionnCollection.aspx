<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="ReAssignBillSumissionnCollection.aspx.cs" Inherits="GUI_Finance_Billing_BillEdit_ReAssignBillSumissionnCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script type="text/javascript" language="javascript" src="../../../../GUI/images/commonJs.js"></script>
<script type="text/javascript" language="javascript">

function locBlur(id)
{
    var txt=document.getElementById(id);

    if(txt.value=="")
        return false;
    txt.value=txt.value.toUpperCase();
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="CheckExist.aspx?mode=loc&code=" + txt.value + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                       var res=findobj.responseText.split("|");
                       if(res[0]=="false")
                       {
                            alert("Location Is not Valid..Enter Proper Location Code....");
                            txt.value="";
                            return false;
                       }
                }
          }
        findobj.send(null);
    }
}



function validateBoxes()
{
   var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
   var r=tbl.rows.length;
   var non=0;
   for(var i=2;i<r;i++)
   {
        //ctl00$MyCPH1$grvcontrols$ctl03$txtsubloc
        var txtbillno,txtsubloc,txtcolloc;
        if(i<10)
            {
                txtbillno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtbillno");
                txtsubloc=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtsubloc");
                txtcolloc=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtcolloc");
            }
        else
            {
                txtbillno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtbillno");
                txtsubloc=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtsubloc");
                txtcolloc=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtcolloc");
            }
            
            if(txtbillno.value!="")
                {
                    non=1;
                    if(txtsubloc.value=="")
                    {
                        alert("Enter Submission Location Proprly.....");
                        txtsubloc.focus();
                        return false;
                    }
                    else if(txtcolloc.value=="")
                    {
                        alert("Enter Collection Location Proprly.....");
                        txtcolloc.focus();
                        return false;
                    }
                }
    } /// end for
    if(non==0)
    {
        alert("There is no Docket Number to Update.........");
        return false;
    }
}

function popuplist(mode,ctlid,tbl)
 { 
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl ;
            confirmWin=window.open(url,"",winOpts);
 }

function addRows()
{
    if(confirm("The Entered Data will be Removed. Are you want to continue...?"))
        return true;
    else
        return false;
}

function billBlur(id)
{
    var str="";
    for(var i=0;i<id.length-9;i++)
    {
        str+=id.charAt(i);
    }
    
    var txtbillno=document.getElementById(id);
    txtbillno.value=txtbillno.value.toUpperCase();
    var str1=str + "txtexsubloc";
    var txtsubloc=document.getElementById(str1);
    var txtcolloc=document.getElementById(str + "txtexcolloc");
    
    var billno=txtbillno.value;
    if(billno=="")
    {
        return false;
    }
 
   var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
   var r=tbl.rows.length;
   
   for(var i=2;i<=r;i++)
   {
        //ctl00$MyCPH1$grvcontrols$ctl03$txtsubloc
        var txtno;
        if(i<10)
            txtno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + i + "$txtbillno");
        else
            txtno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + i + "$txtbillno");

         if(txtbillno.value==txtno.value)
           {
                if(txtbillno.getAttribute('id')!=txtno.getAttribute('id'))
                {
                    alert("Duplicate Document Number....Enter another Document Number....");
                    txtbillno.value="";
                    txtbillno.focus();
                    return false;
                }
           }
 
    }
    
    
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="BringDocDetails.aspx?mode=bill&billno=" + billno + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
          
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert(res[1]);
                        txtbillno.value="";
                        txtbillno.focus();
                        return false;
                    }
                    txtsubloc.value=res[1];
                    txtcolloc.value=res[2];
                }
         }
         
    findobj.send(null);
    }
    
    
    return false;
}

    </script>

    <div align="left" style="width: 10in;">
        <br />
        <br />
        <br /><br />
        <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
            width="100%">
            <tr class="bgbluegrey">
                <td class="blackfnt" align="center"><b>
                    Re-Assign Submission Location and Collection Location</b>
                </td>
            </tr>
        </table>
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                    width="100%">
                    <tr bgcolor="#ffffff">
                        <td class="blackfnt" align="right" width="50%">
                            Enter No. of Rows </td>
                        <td class="blackfnt" align="left" width="50%">
                            <asp:TextBox runat="server" ID="txtnorows" Width="40px" style="text-align:right;" BorderStyle="Groove" MaxLength="2" onkeypress="javascript:return validInt(event);"></asp:TextBox>
                            <asp:Button runat="server" Text="Add Rows" CssClass="blackfnt" OnClick="btnrows_Click" ID="btnrows" />
                        </td>
                    </tr>
                </table>
                <br />
                <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                    width="100%">
                    <tr bgcolor="#ffffff">
                        <td class="blackfnt" align="left">
                            <asp:GridView CssClass="boxbg" runat="server" CellSpacing="1" BorderWidth="0" ID="grvcontrols"
                                AllowPaging="true" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                                OnRowDataBound="grvcontrols_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr. No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Right" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Bill Number">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" BorderStyle="Groove" MaxLength="25" Width="100px" ID="txtbillno"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Existing Submission Location">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtexsubloc" BorderStyle="Groove" Enabled="false" MaxLength="5" Width="60px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            Submission Location<br />
                                            <%--  <asp:TextBox runat="server" ID="txtheadsubloc" BorderStyle="Groove" MaxLength="5" Width="60px"></asp:TextBox>--%>
                                            <asp:Button ID="btnheadsubloc" Text="..." CssClass="blackfnt" runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtsubloc" BorderStyle="Groove" MaxLength="5" Width="60px" runat="server"></asp:TextBox>
                                            <asp:Button ID="btnsubloc" Text="..." CssClass="blackfnt" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Existing Bill Collection Location">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtexcolloc" Enabled="false" BorderStyle="Groove" MaxLength="5" Width="60px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="New Bill Location">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            New Collection Location<br />
                                            <%-- <asp:TextBox runat="server" ID="txtheadcolloc" BorderStyle="Groove" MaxLength="5" Width="60px"></asp:TextBox>--%>
                                            <asp:Button ID="btnheadcolloc" Text="..." CssClass="blackfnt" runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtcolloc" BorderStyle="Groove" MaxLength="5" Width="60px" runat="server"></asp:TextBox>
                                            <asp:Button ID="btncolloc" Text="..." CssClass="blackfnt" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td class="blackfnt" align="center">
                            <asp:Button runat="server" OnClick="btnsubmit_Click" Text="Submit" CssClass="blackfnt"
                                ID="btnsubmit"></asp:Button>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:HiddenField ID="hdnrows" runat="server" Value="5" />
</asp:Content>
