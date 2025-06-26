import Contact from '@salesforce/schema/Contact';
import Email from '@salesforce/schema/Contact.Email';
import Fax from '@salesforce/schema/Contact.Fax';
import FirstName from '@salesforce/schema/Contact.FirstName';
import LastName from '@salesforce/schema/Contact.LastName';
import Phone from '@salesforce/schema/Contact.Phone';
import LightningModal from 'lightning/modal';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreateContactModal extends LightningModal {

    objectApiName = Contact;

    fields = [FirstName,LastName,Email,Phone,Fax];

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: 'Contact created',
            message: 'Record ID: ' + event.detail.id,
            variant: 'success',
        });
        this.dispatchEvent(evt);
        this.close(); 
    }
}