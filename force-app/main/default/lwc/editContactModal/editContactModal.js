import LightningModal from 'lightning/modal';
import Contact from '@salesforce/schema/Contact';
import { api } from 'lwc';
import FirstName from '@salesforce/schema/Contact.FirstName';
import LastName from '@salesforce/schema/Contact.LastName';
import Email from '@salesforce/schema/Contact.Email';
import Phone from '@salesforce/schema/Contact.Phone';
import Fax from '@salesforce/schema/Contact.Fax';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class EditContactModal extends LightningModal {
    objectApiName = Contact; 
    // fields = [FirstName,LastName,Email,Phone,Fax];
    firstName = FirstName
    lastName = LastName
    email = Email
    phone = Phone
    fax = Fax
    @api recordId 

    handleSuccess(){
        this.dispatchEvent(new ShowToastEvent({
            title: 'Contact updated',
            message: 'Record ID: ' + this.recordId,
            variant: 'success',
        }))
        this.close(); 
    }

}