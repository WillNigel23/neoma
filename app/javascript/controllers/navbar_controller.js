import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
    static targets = ["nav", "menu"]

    connect() {
        this.navShown = true;
        this.menuShown = false;
        this.enableOutsideClick = false;
        this.scrollCount = 0;
        this.navTarget.classList.remove('-translate-y-full');
        document.addEventListener('wheel', (event) => this.handleWheel(event));
        document.addEventListener('click', (event) => this.handleClickOut(event));
    }

    handleWheel(event) {
        if (this.menuShown) {
            return;
        }
        if (event.deltaY > 0) {
            this.scrollCount++;

            if (this.scrollCount > 2) {
                if (this.navShown) {
                    this.navShown = !this.navShown;
                    this.changeState(this.navShown, 'y', this.navTarget);
                }
                this.scrollCount = 0;
            }
        }
        else if (event.deltaY < 0) {
            if (!this.navShown) {
                this.navShown = !this.navShown;
                this.changeState(this.navShown, 'y', this.navTarget);
            }
            this.scrollCount = 0;
        }
    }

    toggleMenu() {
        this.menuShown = this.navShown;
        this.navShown = !this.navShown;

        this.changeState(this.navShown, 'y', this.navTarget);
        setTimeout(() => {
            this.changeState(this.menuShown, 'x', this.menuTarget);
            this.enableOutsideClick = this.menuShown;
        }, 250);
    }

    changeState(curState, direction, curTarget) {
        if (curState) {
            curTarget.classList.remove(`-translate-${direction}-full`); }
        else {
            curTarget.classList.add(`-translate-${direction}-full`);
        }
        curTarget.offsetWidth;
    }

    handleClickOut(event) {
        if (this.menuShown && this.enableOutsideClick && event.target.id !== '#menu') {
            this.toggleMenu();
        }
    }
}
