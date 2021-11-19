import { Controller } from "@hotwired/stimulus";
import Tribute from "tributejs";
import Trix from "trix";

export default class extends Controller {
	static targets = ["field"];

	connect() {
		this.editor = this.fieldTarget.editor;
		this.initializeTribute();
	}

	disconnect() {
		this.tribute.detach(this.fieldTarget);
	}
	initializeTribute() {
		this.tribute = new Tribute({
			allowSpaces: true,
			lookup: "username",
			values: this.fetchUsers,
		});
		this.tribute.attach(this.fieldTarget);
		this.tribute.range.pasteHtml = this._pasteHtml.bind(this);
		this.fieldTarget.addEventListener("tribute-replaced", this.replaced);
	}

	fetchUsers(text, callback) {
		fetch(`/mentions.json?query=${text}`)
			.then((res) => res.json())
			.then((json) => callback(json))
			.catch((err) => callback([]));
	}

	replaced(e) {
		let mention = e.detail.item.original;
		let attachment = new Trix.Attachment({
			sgid: mention.sgid,
			content: mention.content,
		});
		this.editor.insertAttachment(attachment);
		this.editor.insertString(" ");
	}

	_pasteHtml(html, start, end) {
		let pos = this.editor.getPosition();
		this.editor.setSelectedRange([pos, end]);
		this.editor.deleteInDirection("backward");
	}
}
