<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ReAssignBacode.aspx.cs" Inherits="GUI_Operations_Re_Assign_BA_ReAssignBacode" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

    <script type="text/javascript" language="javascript" src="../../../../GUI/images/CalendarPopup.js"></script>
    <script type="text/javascript" language="javascript" src="../../../../GUI/images/commonJs.js"></script>
    <script language="javascript" type="text/javascript" >
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
function BaBlur(id)
{
//    var txt=document.getElementById(id);

//    if(txt.value=="")
//        return false;
//    txt.value=txt.value.toUpperCase();
//    var findobj=false;
//    findobj=GetXMLHttpObject();
//    if(findobj)
//    {
//     var strpg="CheckExist.aspx?mode=ba&dockno=" + txt.value + "&sid=" + Math.random();
//     findobj.open("GET",strpg,true);
//     findobj.onreadystatechange=function()
//         {
//             if(findobj.readyState==4 && findobj.status==200)
//                {
//                       var res=findobj.responseText.split("|");
//                       if(res[0]=="false")
//                       {
//                            alert("BA Code Is not Valid..Enter Proper BA Code....");
//                            txt.value="";
//                            return false;
//                       }
//                }
//          }
//        findobj.send(null);
//    }
}
var doc = null; 
var MyDiv = document.getElementById("ReportingToCombo");
	var formObj = null;
function createXMLHTTPObject()
	{
	    if (window.XMLHttpRequest) { // Mozilla, Safari,...
	        doc = new XMLHttpRequest();
	        if (doc.overrideMimeType) 
	        {
	            doc.overrideMimeType('text/xml');
	        }
	    } else if (window.ActiveXObject) { // IE
	        try {
	            doc = new ActiveXObject("Msxml2.XMLHTTP");
	        } catch (e) {
	            try {
	                doc = new ActiveXObject("Microsoft.XMLHTTP");
	            } catch (e) {}
	        }
	    }
	}
	var txt
function Dockblur(obj)
{
    //debugger;
    txt=document.getElementById(obj);
     //alert(txt)
    str_ba_fieldname=obj.replace("txtdocno","txtexbacode")
    str_hdnfld=obj.replace("txtdocno","hdnfld")
    
   // alert(str_ba_fieldname)
    if(txt.value=="")
        return false;
    txt.value=txt.value.toUpperCase();
    var findobj=false;
    
    createXMLHTTPObject();
    if(doc)
    {
             var strpg="CheckExist.aspx?mode=docket&dockno=" + txt.value + "&sid=" + Math.random();
                         doc.onreadystatechange = doWork; 
					    doc.open("GET",strpg, false);
					    doc.send(null);
    }
}
        function doWork() {
	    if (doc.readyState == 4) {
	            //alert(doc.responseText)
	                val=doc.responseText
	                   var res=doc.responseText.split("|");
				       if(res[0]=="false")
                       {
                            alert(res[1]);
                            txt.value="";
                            return false;
                       }
                       else
                       {
                                document.getElementById(str_ba_fieldname).value=res[1];
                                document.getElementById(str_hdnfld).value=res[2];
                       }
				//MyDiv.innerHTML = doc.responseText;
				//document.form1.submit1.focus();
	    }
	}	

function validateBoxes()
{
   //debugger;
   var tbl=document.getElementById("ctl00_MyCPH1_grvcontrols");
   var r=tbl.rows.length;
   var non=0;
   for(var i=0;i<r-1;i++)
   {
        //ctl00$MyCPH1$grvcontrols$ctl03$txtsubloct
        var txtbacode,txtdocno;
        j=i+2
        if(j<10)
            {
                txtdocno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + j + "$txtdocno");
                txtbacode=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl0" + j + "$txtbacode");
            }
        else
            {
                txtdocno=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + j + "$txtdocno");
                txtbacode=document.getElementById("ctl00$MyCPH1$grvcontrols$ctl" + j + "$txtbacode");
            }
            
            if(txtdocno.value!="")
                {
                    non=1;
                    if(txtbacode.value=="")
                    {
                        alert("Enter BA Code Proprly.....");
                        txtbacode.focus();
                        return false;
                    }
                   
                }
    } /// end for
    if(non==0)
    {
        alert("There is no Document Number to Update.........");
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
    //debugger;
    var txt = document.getElementById("ctl00_MyCPH1_txtnorows");
    if(txt.value == "")
      {
        alert("Enter No of rows Proprly.....");
        txt.focus();
        return false;
      }  
    if(confirm("The Entered Data will be Removed. Are you want to continue...?"))
        return true;
    else
        return false;
}
    </script>
  <div align="left" style="width: 10in;">
    <table border="0" cellpadding="0" class="boxbg" cellspacing="0">
        <tr bgcolor="white">
            <td align="left" colspan="5" height="30" style="width: 459px">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                <b>Operations</b></font></a> <b>&gt; </b><a href=""><font class="blklnkund">
                <b>Re-Assign Ba code</b></font></a> <b>&gt;</b>
            </td>
        </tr>
    </table>
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="100%">
        <tr class="bgbluegrey">
            <td class="blackfnt" align="center">
                <b>Re-Assign BA Code </b>
            </td>
        </tr>
    </table>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                    width="100%">
                    <tr bgcolor="#ffffff">
                        <td class="blackfnt" align="right" width="50%">
                            Enter No. of Rows </td>
                        <td class="blackfnt" align="left" width="50%">
                            <asp:TextBox runat="server" ID="txtnorows" Width="40px" style="text-align:right;" BorderStyle="Groove" MaxLength="2" onkeypress="javascript:return validInt(event)"></asp:TextBox>
                            <asp:Button runat="server" Text="Add Rows" CssClass="blackfnt" OnClick="btnrows_Click" ID="btnrows" />
                        </td>
                    </tr>
                </table>
                <br />
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
        <asp:Table ID="Table1" runat="server">
        <asp:TableRow>
        <asp:TableCell><asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" /></asp:TableCell>
        <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
        </asp:TableRow>
        </asp:Table>
        </ProgressTemplate>
        </asp:UpdateProgress>
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
                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Document Number">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" BorderStyle="Groove" MaxLength="25" Width="100px" ID="txtdocno"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Existing BA Code">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtexbacode" BorderStyle="Groove" Enabled="false" MaxLength="5" Width="60px" runat="server"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            New BA Code<br />
                                              <asp:TextBox runat="server" ID="txtnewbacode" BorderStyle="Groove" MaxLength="5" Width="60px"></asp:TextBox>
                                            <asp:Button ID="btnnewbacode" Text="..." CssClass="blackfnt" runat="server" />
                                        </HeaderTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtbacode" BorderStyle="Groove" MaxLength="50" Width="60px" runat="server"></asp:TextBox>
                                            <asp:Button ID="btnbacode" Text="..." CssClass="blackfnt" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" BackColor="#d4e0e7" CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                           <asp:HiddenField ID="hdnfld" runat="server" /> 
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
    <asp:HiddenField ID="hidden_val_name" runat="server" Value="" />
</asp:Content>

