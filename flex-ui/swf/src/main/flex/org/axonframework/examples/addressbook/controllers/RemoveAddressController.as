/*
 * Copyright (c) 2010. Axon Framework
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.axonframework.examples.addressbook.controllers {
import mx.rpc.AsyncToken;

import org.axonframework.examples.addressbook.commands.RemoveAddressCommand;
import org.axonframework.examples.addressbook.messages.command.RemoveAddressCommandMessage;
import org.axonframework.examples.addressbook.messages.notification.NotificationMessage;
import org.axonframework.examples.addressbook.model.Address;
import org.axonframework.examples.addressbook.model.Contact;

public class RemoveAddressController extends BaseController {
    private var address:Address;
    private var contact:Contact;

    public function RemoveAddressController() {
        super();
    }

    public function execute(message:RemoveAddressCommandMessage):AsyncToken {
        this.address = message.address;
        this.contact = message.contact;

        var removeAddressCommand:RemoveAddressCommand = new RemoveAddressCommand();
        removeAddressCommand.contactId = address.contactUUID;
        removeAddressCommand.addressType = address.type;

        return commandReceiver.sendCommand(removeAddressCommand);
    }

    public function result():void {
        dispatcher(new NotificationMessage(
                this.address.type + " address for : " + this.address.contactName + " removed"));
    }

}
}