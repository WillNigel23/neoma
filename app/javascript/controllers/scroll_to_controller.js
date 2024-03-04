import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll-to"
export default class extends Controller {
  static targets = ['item']
  static values = {
    offset: {
      default: 150,
      type:Number 
    }
  } 
  activeNavItem = null;
  
  connect() {
    setTimeout( () => {
      this.element.classList.toggle('-translate-x-full');
    }, 500);
    window.addEventListener('scroll', this.handleScroll.bind(this));
  }

  handleScroll(event) {
    const scrollPosition = window.scrollY;
    let currentActiveNavItem = null;

    this.itemTargets.forEach((nav_item) => {
      const scrollId = nav_item.getAttribute('data-scroll-id');
      const section = document.getElementById(`${scrollId}`);
      if (section) {
        const sectionTop = section.getBoundingClientRect().top - 
                           document.body.getBoundingClientRect().top -
                           this.offsetValue
        const sectionBottom = sectionTop + section.offsetHeight;

        if (scrollPosition >= sectionTop && scrollPosition < sectionBottom) {
          currentActiveNavItem = nav_item;
        }
      }

      if (currentActiveNavItem !== this.activeNavItem) {
        if (this.activeNavItem) {
          this.activeNavItem.classList.remove('border-b-[1.2px]', 'border-black');
        }

        if (currentActiveNavItem) {
          currentActiveNavItem.classList.add('border-b-[1.2px]', 'border-black');
        }

        this.activeNavItem = currentActiveNavItem;
      }
    });
  }

  click(event) {
    const targetElement = document.getElementById(`${event.target.getAttribute('data-scroll-id')}`);
    
    if(targetElement) {
      window.scrollTo({
        behavior: 'smooth',
        top: 
          targetElement.getBoundingClientRect().top - 
          document.body.getBoundingClientRect().top -
          this.offsetValue
      });
    }
  }
}
