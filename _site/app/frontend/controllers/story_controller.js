import { Controller } from 'stimulus';
import axios from 'axios';
 
export default class extends Controller {
  static targets = ['likesCount','likeIcon'];
  

  toggleLike(e) {
  e.preventDefault();

  const slug = e.currentTarget.dataset.slug;
  const token = document.querySelector('[name=csrf-token]').content
axios.defaults.headers.common['X-CSRF-TOKEN'] = token
  // 執行 AJAX 請求
  axios.post(`/stories/${slug}/like`, {})
    .then(response => {
      const likesCount = response.data.likes_count;
      const isLiked = response.data.is_liked; // 假設伺服器返回了按讚狀態
      this.likesCountTarget.textContent = likesCount
      console.log('New likes count:', likesCount);
      
      localStorage.setItem('isLiked', isLiked);
      // 根據按讚狀態切換圖標或執行其他操作
      this.toggleLikeIcon(isLiked);
    })
    .catch(error => console.log('Error:', error));
  }

  toggleLikeIcon(isLiked) {
    const icon = this.likeIconTarget;
    icon.classList.toggle('fa-regular', !isLiked);
    icon.classList.toggle('fa-solid', isLiked);
  }
  
  connect() {
    const likesCount = this.data.get('likesCount');
    const isLiked = this.data.get('isLiked') === 'true';

    this.likesCountTarget.textContent = likesCount;
    this.toggleLikeIcon(isLiked);
  }

  

}
