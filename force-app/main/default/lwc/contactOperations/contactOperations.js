import deleteContact from '@salesforce/apex/ContactController.deleteContact';
import getContactList from '@salesforce/apex/ContactController.getContactList';
import CreateContactModal from 'c/createContactModal';
import EditContactModal from 'c/editContactModal';
import { LightningElement, track, wire } from 'lwc';

const columns = [
    { label: 'Id', fieldName: 'Id' },
    { label: 'FirstName', fieldName: 'FirstName' },
    { label: 'LastName', fieldName: 'LastName' },
    { label: 'Phone', fieldName: 'Phone' },
    { label: 'Email', fieldName: 'Email' },
    { label: 'Fax', fieldName: 'Fax' },
    {
        type: 'action', typeAttributes:{
            rowActions:[
               { label: 'Edit',name: 'edit'},
               { label: 'Delete',name: 'delete'}
            ]
        }
    }
];

export default class ContactOperations extends LightningElement {
    @track data;
    
    columns = columns;

    @wire(getContactList)
    wiredContacts({ data,error }){
        if(data){
            this.data = data;
        }else if(error){
            this.showToast('Error',error.message,'error');
        }
    }    
    
    async handleNewButton(){
        await CreateContactModal.open(); 
    }

    handleRowAction(event){

        console.log("row action invoked",event); 

        const action = event.detail.action.name; 
        const row = event.detail.row; 
        const id = row.Id; 
        if(action == 'edit'){
            EditContactModal.open({recordId:id});
        }
        else if(action = 'delete'){
            deleteContact({contactId:id})
            .then(()=>{
                this.showToast('Success','Contact deleted successfully','success');
                return refreshApex(this.wiredContacts);
            })
            .catch((error)=>{
                this.showToast('Error',error.message,'error');
            }); 
        }
        return; 
    }

    showToast(title,message,type){
        const event = new ShowToastEvent({
            title: title,
            message:message, variant: type}); 
        this.dispatchEvent(event);
    }

}