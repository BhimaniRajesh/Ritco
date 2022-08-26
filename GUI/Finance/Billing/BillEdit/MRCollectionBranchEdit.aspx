<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="MRCollectionBranchEdit.aspx.cs" Inherits="GUI_Finance_Billing_BillEdit_ReAssignBillSumissionnCollection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script type="text/javascript" language="javascript" src="../../../../GUI/images/commonJs.js"></script>
<script type="text/javascript" language="javascript">
function partyList(ctlid)
{
    window.open("DataPopUp.aspx?mode=location&ctlid=" + ctlid + "&tbl=none",null,'left=300, top=150, height=300, width= 300, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no')
    return false;
}

function validateBoxes()
{
   var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
   var r=tbl.rows.length;
   var non=0;
   var chk;
   for(var i=2;i<r;i++)
   {
        //ctl00_MyCPH1_grvcontrols_ctl03_txtsubloc
        var txtmrsno;
        var txtnewlocno;
        var pref="";
        if(i<10)
            pref= "ctl00_MyCPH1_grvcontrols_ctl0" + i + "_";
        else
            pref= "ctl00_MyCPH1_grvcontrols_ctl0" + i + "_";
        
               
            chk=document.getElementById(pref + "chkyes");
            txtmrsno=document.getElementById(pref + "txtmrsno");
            txtnewlocno=document.getElementById(pref + "txtnewcolbranch");
            if(chk.checked==true)
            {
                if(txtmrsno.value=="")
                {
                    alert("Please Enter MR Number...");
                    txtmrsno.select();
                    return false;
                }
                
                if(txtnewlocno.value=="")
                {
                    alert("Please Enter MR Number...");
                    txtnewlocno.select();
                    return false;
                }
                non++;
            }
                        
    } /// end for
    
    
    if(non==0)
    {
        alert("There is no MR Number to Update.........");
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

function mrsBlur(id)
{
    var str="";
    for(var i=0;i<id.length-8;i++)
    {
        str+=id.charAt(i);
    }
    
    var txtmrsno=document.getElementById(id);
    txtmrsno.value=txtmrsno.value.toUpperCase();
    var str1=str + "lblexcolbranch";
    var lblexcolbranch=document.getElementById(str1);
    
    
    var mrsno=txtmrsno.value;
    if(mrsno=="")
    {
        return false;
    }
 
   var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
   var r=tbl.rows.length;
   var pref="";
   for(var i=2;i<r;i++)
   {
        //ctl00_MyCPH1_grvcontrols_ctl03_txtsubloc
        var txtno;
        if(i<10)
            pref= "ctl00_MyCPH1_grvcontrols_ctl0" + i + "_";
        else
            pref = "ctl00_MyCPH1_grvcontrols_ctl" + i + "_";

        txtno=document.getElementById(pref + "txtmrsno");

         if(txtmrsno.value==txtno.value)
           {
                if(txtmrsno.getAttribute('id')!=txtno.getAttribute('id'))
                {
                    alert("Duplicate MR Number....Enter another MR Number....");
                    txtmrsno.value="";
                    txtmrsno.select();
                    return false;
                }
           }
 
    }
    
    
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="BringDocDetails.aspx?mode=mrcolbranch&mrsno=" + mrsno + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
            
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert(res[1]);
                        txtmrsno.value="";
                        txtmrsno.select();
                        return false;
                    }
                    else if(res[0]=="true")
                    {
                        lblexcolbranch.innerText=res[1];
                    }
                    
                }
         }
         
    findobj.send(null);
    }
    
    
    return false;
}


function newBranchBlur(id)
{

    var txt=document.getElementById(id);
    
    txt.value=txt.value.toUpperCase();
    if(txt.value=="")
        return false;
        
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="BringDocDetails.aspx?mode=loccode&loccode=" + txt.value + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert(res[1]);
                        txt.value="";
                        txt.select();
                        return false;
                    }
                }
         }
         
    findobj.send(null);
    }
    
}
    </script>
    <div align="center" style="width: 10in;">
        <br />
        <br />
        <br /><br />
        <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
            width="85%">
            <tr class="bgbluegrey">
                <td class="blackfnt" align="center"><b>
                    Edit MR Collection Branch </b>
                </td>
            </tr>
        </table>
        <br />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                    width="85%">
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
                    width="85%">
                    <tr bgcolor="#ffffff">
                        <td class="blackfnt" align="left">
                            <asp:GridView CssClass="boxbg" runat="server" CellSpacing="1" BorderWidth="0" ID="grvcontrols"
                                AllowPaging="true" Width="100%" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                                FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                                OnRowDataBound="grvcontrols_RowDataBound">
                                <Columns>
                                   <asp:TemplateField HeaderText="">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" Width="3%" />
                                        <ItemStyle Width="10px" CssClass="blackfnt" BackColor="white" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkyes" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="MR Number">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" Width="30%" />
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtmrsno" runat="server" CssClass="blackfnt" BorderStyle="Groove" onblur="javascript:return mrsBlur(this.getAttribute('id'))" MaxLength="25" Width="150"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Existing Branch">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" Width="40%" />
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblexcolbranch" runat="server" CssClass="blackfnt"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" Width="27%" />
                                        <HeaderTemplate>
                                            New Branch
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtnewcolbranch" CssClass="blackfnt" runat="server" onblur="javascript:return newBranchBlur(this.getAttribute('id'));" BorderStyle="Groove" MaxLength="5" Width="100px"></asp:TextBox>
                                            <input type="button" id="btnnewcolbranch" runat="server" class="blackfnt" value="..." />
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
