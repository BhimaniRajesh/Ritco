<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="AirportListing.aspx.cs" Inherits="GUI_admin_AirportMaster_AirportListing" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script language ="javascript" type="text/javascript" >
var airportval="<%=airportstr%>";
var tmptext="<%=tmptext%>";
var doc = null; 
var formobj;
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
	function doWork() {
	    if (doc.readyState == 4) {
	     //alert(doc.responseText)
	           //debugger
	           if (doc.responseText!="OK")
	           {
	            alert(doc.responseText)
	            formobj.value="";
	            formobj.focus();
	           }
	           // val=doc.responseText
				
				//MyDiv.innerHTML = doc.responseText;
				//document.form1.submit1.focus();
	    }
	}
	

        
        
        function airportcheck(obj,edittext)
        {
        formobj=obj
        obj.value = obj.value.toUpperCase()
                        if(obj.value!=edittext.value && obj.value!="")
                        {
                                createXMLHTTPObject();
                                //alert("hi.............0")
				            if (doc)
				            { 
				           
				                arg=new Date()
					            doc.onreadystatechange = doWork; 
					            doc.open("GET", "dyn_combo.aspx?EditedAirport=" + obj.value + "&RandText="+arg, false);
					            doc.send(null);
					            //alert(chqno)
				            }
				           
				       }
        }
</script> 

    <div align="center">
        <br />
        <div align="left">
        <a><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a><font class="blklnkund"><b>Administrator</b></font></a>
							<b> &gt; </b>
							<a href="../company_structure.aspx"><font class="blklnkund"><b>Company Structure</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>Airport Master</b></font></div>
        <div align="right">  
        <a href="javascript:window.history.go(-1)"  title="back"><img src="../../images/back.gif" border="0" alt="" /></a>
        </div>
        <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
    <ContentTemplate>
    <asp:GridView ShowFooter="true" ID="GrdPaidFollow" PagerStyle-Mode="NumericPages" CssClass="boxbg" PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"  BackColor="white" runat="server" SelectedIndex="1" OnRowEditing="GrdPaidFollow_RowEditing" OnRowCancelingEdit="GrdPaidFollow_RowCancelingEdit" OnRowUpdating="GrdPaidFollow_RowUpdating" OnRowDeleting="GrdPaidFollow_RowDeleting" OnRowCreated="GrdPaidFollow_RowCreated" OnRowDataBound="GrdPaidFollow_RowDataBound"> 
    <Columns>
     <asp:TemplateField ItemStyle-Width="337"  HeaderText="Airport Code">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                
                <asp:Label ID="lblacode" CssClass="blackfnt" Width="337" runat="server" Text='<%# Eval("airportcode") %>' ></asp:Label> 
        
                </ItemTemplate>
                <EditItemTemplate>
                <asp:Label ID="lblacode" CssClass="blackfnt"  Width="337" runat="server" Text='<%# Eval("airportcode") %>' ></asp:Label>                 
                <%--<asp:TextBox ID="txtgcode" Width="337" MaxLength="50"   runat="server" Text='<%# Eval("airportcode") %>' ></asp:TextBox>         --%>
                
                </EditItemTemplate> 
    </asp:TemplateField>
    
    <asp:TemplateField ItemStyle-Width="337"  HeaderText="Airport City">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                
                <asp:Label ID="lblaname" Width="337" CssClass="blackfnt" runat="server" Text='<%# Eval("airportcity") %>' ></asp:Label> 
                <%--<asp:TextBox ID="txtgname" Width="337" MaxLength="50"   runat="server" Text='<%# Eval("airportcity") %>' ></asp:TextBox> --%>
                </ItemTemplate>
                <EditItemTemplate>
                
                <asp:TextBox ID="txtaname" Width="337" CssClass="blackfnt" MaxLength="50" runat="server" Text='<%# Eval("airportcity") %>' ></asp:TextBox>                 
               <asp:HiddenField  Value='<%# Eval("airportcity") %>'  ID="editAirport" runat="server" />
                </EditItemTemplate> 
    </asp:TemplateField>
    
    <asp:TemplateField>
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                <asp:Button Text="  Edit  " ID="CmdEdit" runat="server" CommandName="Edit" UseSubmitBehavior="false"/>  
                </ItemTemplate>
                <EditItemTemplate>
                <asp:Button Text="Update" ID="CmdUpdate" runat="server" CommandName="Update" UseSubmitBehavior="false"/>  
                <asp:Button Text="Cancel" ID="CmdCancel" runat="server" CommandName="Cancel" UseSubmitBehavior="false"/>  
                </EditItemTemplate> 
    </asp:TemplateField>  
    
    <asp:TemplateField>
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                <asp:Button Text="Delete" Visible="false" ID="CmdDelete" runat="server" CommandName="Delete" UseSubmitBehavior="false"/>  
                <asp:Button Text="Delete" OnClientClick="return confirm('Are You Sure Want To Delete ?')"  ID="CmdDeleteExtern" OnClick="delairport"  runat="server"  UseSubmitBehavior="true"/>  
                </ItemTemplate>
                <FooterTemplate>
                <asp:Button Text="  Add  " ID="CmdAdd" runat="server" CommandName="Add" UseSubmitBehavior="true" PostBackUrl="~/GUI/admin/AirportMaster/AirportMasterAdd.aspx"/>  
                </FooterTemplate> 
    </asp:TemplateField>  
    
      
    </Columns> 
    </asp:GridView>
    </ContentTemplate> 
    </asp:UpdatePanel>       
    </div>
    </asp:Content>
