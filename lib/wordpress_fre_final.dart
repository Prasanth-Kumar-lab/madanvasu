// <?php
// /**
//  *  Functions and definitions for auxin framework
//  *
//  *
//  * @package    Auxin
//  * @author     averta (c) 2014-2023
//  * @link       http://averta.net
//  */
//
// /*-----------------------------------------------------------------------------------*/
// /*  Add your custom functions here -  We recommend you to use "code-snippets" plugin instead
// /*  https://wordpress.org/plugins/code-snippets/
// /*-----------------------------------------------------------------------------------*/
//
// /*-----------------------------------------------------------------------------------*/
// /*  Init theme framework
// /*-----------------------------------------------------------------------------------*/
// require( 'auxin/auxin-include/auxin.php' );
// /*-----------------------------------------------------------------------------------*/
//
// /**
//  *  Functions and definitions for auxin framework
//  *
//  *
//  * @package    Auxin
//  * @author     averta (c) 2014-2023
//  * @link       http://averta.net
//  */
//
// /*-----------------------------------------------------------------------------------*/
// /*  Add your custom functions here -  We recommend you to use "code-snippets" plugin instead
// /*  https://wordpress.org/plugins/code-snippets/
// /*-----------------------------------------------------------------------------------*/
//
// /*-----------------------------------------------------------------------------------*/
// /*  Init theme framework
// /*-----------------------------------------------------------------------------------*/
// require( 'auxin/auxin-include/auxin.php' );
// /*-----------------------------------------------------------------------------------*/
// add_action( 'woocommerce_before_calculate_totals', 'force_cart_quantity_to_one_per_product', 10, 1 );
//
// function force_cart_quantity_to_one_per_product( $cart ) {
//     if ( is_admin() && ! defined( 'DOING_AJAX' ) ) {
//         return;
//     }
//
//     // Ensure the cart is not empty
//     if ( WC()->cart->is_empty() ) {
//         return;
//     }
//
//     // Get the total number of unique products in the cart
//     $cart_count = count( $cart->get_cart() );
//
//     // If there are exactly 2 different products in the cart
//     if ( $cart_count == 2 ) {
//         foreach ( $cart->get_cart() as $cart_item_key => $cart_item ) {
//             if ( $cart_item['quantity'] > 1 ) {
//                 $cart_item['quantity'] = 1; // Set quantity to 1
//             }
//         }
//     }
// }
//
//
//
//
// // Set maximum quantity to 2 for all products
// add_filter('woocommerce_quantity_input_args', 'set_max_quantity_limit', 10, 2);
// function set_max_quantity_limit($args, $product) {
//     if(is_cart()) {
//         $args['max_value'] = 2;
//     }
//     return $args;
// }
//
// // Validate quantity when cart is updated
// add_filter('woocommerce_add_to_cart_validation', 'validate_max_quantity', 10, 3);
// function validate_max_quantity($passed, $product_id, $quantity) {
//     if($quantity > 2) {
//         wc_add_notice(__('Maximum quantity allowed is 2', 'your-text-domain'), 'error');
//         $passed = false;
//     }
//     return $passed;
// }
//
// // Enqueue custom scripts
// add_action('wp_enqueue_scripts', 'cart_quantity_scripts');
// function cart_quantity_scripts() {
//     if(is_cart()) {
//         wp_enqueue_script('cart-quantity-ajax', get_stylesheet_directory_uri() . '/cart-quantity.js', array('jquery'), '1.0', true);
//         wp_localize_script('cart-quantity-ajax', 'cart_ajax', array(
//             'ajax_url' => admin_url('admin-ajax.php')
//         ));
//     }
// }
//
//
//
//
// function limit_cart_item_quantity( $passed, $product_id, $quantity, $variation_id = 0 ) {
//     $cart_count = 0;
//
//     // Loop through cart items
//     foreach ( WC()->cart->get_cart() as $cart_item ) {
//         if ( $cart_item['product_id'] == $product_id ) {
//             $cart_count += $cart_item['quantity'];
//         }
//     }
//
//     // Check if the limit is exceeded
//     if ( ( $cart_count + $quantity ) > 2 ) {
//         wc_add_notice( __( "You can only add up to 2 of this product.", "woocommerce" ), "error" );
//         return false;
//     }
//
//     return $passed;
// }
//
// /**
//  * Limit total cart items to 2.
//  *
//  * This snippet checks the total quantity in the cart and prevents
//  * adding more items if the limit is reached.
//  */
// add_filter( 'woocommerce_add_to_cart_validation', 'restrict_cart_quantity_to_two', 10, 3 );
// function restrict_cart_quantity_to_two( $passed, $product_id, $quantity ) {
//     $max_allowed = 2;
//     $current_total = WC()->cart->get_cart_contents_count();
//
//     if ( ( $current_total + $quantity ) > $max_allowed ) {
//         wc_add_notice( sprintf( 'You have reached the limit of %d cans in your cart.', $max_allowed ), 'error' );
//
//         // Redirect users to the cart page where the message is visible
//         wc_add_notice( '<a href="'.wc_get_cart_url().'">View Cart</a>', 'notice' );
//         return false;
//     }
//
//     return $passed;
// }
//
//
// add_filter( 'woocommerce_add_to_cart_validation', 'restrict_cart_quantity_to_two', 10, 3 );
// remove_action('woocommerce_proceed_to_checkout', 'woocommerce_button_proceed_to_checkout', 20);
//
// // Validate Pincode and Area Selection
// function validate_pincode_and_area( $data, $errors ) {
//     $allowed_pincodes = array('560093', '560075', '560008');
//
//     if ( isset( $data['billing_postcode'] ) && !in_array($data['billing_postcode'], $allowed_pincodes) ) {
//         $errors->add( 'billing', __( 'We are not available in this area yet. Please enter a valid pincode (560093).', 'woocommerce' ) );
//     }
//
//
// }
// add_action( 'woocommerce_after_checkout_validation', 'validate_pincode_and_area', 10, 2 );
// add_action('wp_ajax_woocommerce_ajax_add_to_cart', 'handle_ajax_add_to_cart');
// add_action('wp_ajax_nopriv_woocommerce_ajax_add_to_cart', 'handle_ajax_add_to_cart');
//
// function handle_ajax_add_to_cart() {
//     if (!isset($_POST['product_id']) || !isset($_POST['quantity'])) {
//         echo json_encode(['success' => false, 'message' => 'Invalid request']);
//         wp_die();
//     }
//
//     $product_id = intval($_POST['product_id']);
//     $quantity = intval($_POST['quantity']);
//     $cart_item_key = WC()->cart->add_to_cart($product_id, $quantity);
//
//     if (!$cart_item_key) {
//         echo json_encode(['success' => false, 'message' => 'Could not add product']);
//         wp_die();
//     }
//
//     $cart_count = WC()->cart->get_cart_contents_count();
//     echo json_encode(['success' => true, 'cart_count' => $cart_count, 'quantity' => $quantity]);
//     wp_die();
// }
//
//
//
//
// // 1. Create a function that returns a Back link if we're on a product category page.
// function show_back_link_if_category() {
//     // If we are on a product category archive page...
//     if ( is_product_category() ) {
//         // Get the main shop page URL
//         $shop_url = get_permalink( wc_get_page_id('shop') );
//
//         // Return a simple "Back" link. Style it however you like.
//         return '<div class="back-to-shop">
//                     <a class="back-link" href="' . esc_url( $shop_url ) . '">
//                         &larr; Back
//                     </a>
//                 </div>';
//     }
//
//     // If not on a category page, return nothing
//     return '';
// }
//
// // 2. Register a shortcode [back_link_if_category] that calls the above function
// add_shortcode('back_link_if_category', 'show_back_link_if_category');
//
// /**
// <?php
// /**
//  * 1) Global Error Container & Basic Styles
//  * 2) Shop/Archive AJAX-based Cart Controls
//  * 3) Single Product Page Limit Handling (no custom toggle override, just max=2)
//  * 4) AJAX Backends (Get/Update/Remove)
//  * 5) WooCommerce Hooks: Strict Global Limit of 2
//  * 6) Password Visibility Toggle
//  * 7) Existing Email Check Script
//  */
//
//
// /* ----------------------------------------------------------------------------
//    1. GLOBAL ERROR CONTAINER & STYLES
// ---------------------------------------------------------------------------- */
// add_action('wp_head', 'custom_cart_css');
// function custom_cart_css() {
//     ?>
//     <style>
//     /* Modern Custom Quantity Controls (for Shop/Archive) */
//     .custom-quantity {
//         display: inline-flex;
//         align-items: center;
//         gap: 8px;
//         margin-top: 10px;
//     }
//     .custom-qty-btn {
//         width: 40px;
//         height: 40px;
//         border: none;
//         background: #0073aa;
//         color: #fff;
//         border-radius: 0;
//         font-size: 20px;
//         display: flex;
//         align-items: center;
//         justify-content: center;
//         transition: background-color 0.3s, transform 0.2s;
//         cursor: pointer;
//     }
//     .custom-qty-btn:hover {
//         background: #005077;
//         transform: scale(1.05);
//     }
//     .custom-qty-input {
//         width: 50px;
//         text-align: center;
//         font-size: 16px;
//         padding: 5px;
//         border: 1px solid #ddd;
//         border-radius: 4px;
//         outline: none;
//         transition: border-color 0.3s;
//         pointer-events: none; /* no manual typing */
//         background: #f9f9f9;
//     }
//     .custom-qty-input:focus {
//         border-color: #0073aa;
//     }
//
//     /* Fixed error message styling */
//     #custom-cart-error {
//         position: fixed;
//         left: 20px;
//         bottom: 20px;
//         z-index: 9999;
//         background: rgba(255, 0, 0, 0.85);
//         color: #fff;
//         padding: 10px 15px;
//         border-radius: 4px;
//         font-size: 14px;
//         opacity: 0;
//         transition: opacity 0.3s ease-in-out;
//     }
//     #custom-cart-error.show {
//         opacity: 1;
//     }
//     @media (max-width: 600px) {
//         .custom-qty-btn {
//             width: 35px;
//             height: 35px;
//             font-size: 18px;
//         }
//         .custom-qty-input {
//             width: 40px;
//             font-size: 14px;
//         }
//     }
//     </style>
//     <?php
// }
//
// // Add a global container for error messages on every page
// add_action('wp_footer', 'add_global_error_container');
// function add_global_error_container() {
//     echo '<div id="custom-cart-error"></div>';
// }
//
//
// /* ----------------------------------------------------------------------------
//    2. SHOP/ARCHIVE: AJAX-BASED CART CONTROLS
// ---------------------------------------------------------------------------- */
// add_action('wp_footer', 'custom_cart_quantity_handler_shop');
// function custom_cart_quantity_handler_shop() {
//     // Only run on front page, shop, taxonomy, or archive (NOT single product)
//     if ( is_front_page() || is_shop() || is_product_taxonomy() || is_archive() ) : ?>
//     <script type="text/javascript">
//     jQuery(document).ready(function($) {
//
//         // Utility: Show error in bottom-left
//         function showError(message) {
//             var $error = $('#custom-cart-error');
//             $error.text(message).addClass('show');
//             setTimeout(function() {
//                 $error.removeClass('show');
//             }, 3000);
//         }
//
//         // Utility: Sum all custom-qty-input values
//         function getGlobalCartQuantity() {
//             var total = 0;
//             $('.custom-qty-input').each(function(){
//                 total += parseInt($(this).val()) || 0;
//             });
//             return total;
//         }
//
//         // 2.1 On load, fetch cart items and replace "Add to Cart" with quantity controls
//         $.ajax({
//             url: wc_add_to_cart_params.ajax_url,
//             data: { action: 'get_cart_items' },
//             success: function(response) {
//                 response.forEach(function(item) {
//                     var $button = $('.add_to_cart_button[data-product_id="' + item.id + '"]');
//                     if ($button.length) {
//                         var qtyControls = showQuantityControls($button, item.quantity);
//                         attachQuantityHandlers(qtyControls, item.id);
//                     }
//                 });
//             }
//         });
//
//         // 2.2 Replace the add-to-cart button with custom +/- controls
//         function showQuantityControls($button, quantity) {
//             $button.hide();
//             var qtyHtml = `
//                 <div class="custom-quantity">
//                     <button class="custom-qty-btn minus">–</button>
//                     <input type="number" class="custom-qty-input" value="${quantity}" min="1" max="2" readonly />
//                     <button class="custom-qty-btn plus">+</button>
//                 </div>
//             `;
//             $button.after(qtyHtml);
//             var $qtyControls = $button.next('.custom-quantity');
//             $qtyControls.data('originalButton', $button);
//             return $qtyControls;
//         }
//
//         // 2.3 Handle clicks on "Add to Cart" (shop/archive)
//         $(document).on('click', '.add_to_cart_button', function(e) {
//             e.preventDefault();
//             if ( getGlobalCartQuantity() >= 2 ) {
//                 showError("Maximum cart limit reached.");
//                 return;
//             }
//             var $button = $(this);
//             var product_id = $button.data('product_id');
//
//             // Double-check
//             if ( getGlobalCartQuantity() + 1 > 2 ) {
//                 showError("Maximum cart limit reached.");
//                 return;
//             }
//
//             $.ajax({
//                 url: wc_add_to_cart_params.ajax_url,
//                 method: 'POST',
//                 data: {
//                     action: 'woocommerce_add_to_cart',
//                     product_id: product_id,
//                     quantity: 1
//                 },
//                 success: function(response) {
//                     if ( ! response.error ) {
//                         var qtyControls = showQuantityControls($button, 1);
//                         attachQuantityHandlers(qtyControls, product_id);
//                     }
//                 }
//             });
//         });
//
//         // 2.4 Attach plus/minus handlers
//         function attachQuantityHandlers(qtyControls, product_id) {
//             // Plus
//             qtyControls.find('.custom-qty-btn.plus').off('click').on('click', function() {
//                 var $input = qtyControls.find('.custom-qty-input');
//                 var currentVal = parseInt($input.val());
//                 var newTotal = getGlobalCartQuantity() + 1;
//                 if ( newTotal > 2 ) {
//                     showError("Maximum cart limit reached.");
//                     return;
//                 }
//                 if ( currentVal < 2 ) {
//                     var newVal = currentVal + 1;
//                     $input.val(newVal);
//                     updateCartQuantity(product_id, newVal);
//                 }
//             });
//
//             // Minus
//             qtyControls.find('.custom-qty-btn.minus').off('click').on('click', function() {
//                 var $input = qtyControls.find('.custom-qty-input');
//                 var currentVal = parseInt($input.val());
//                 if ( currentVal === 1 ) {
//                     // Remove from cart
//                     $(this).prop('disabled', true);
//                     var originalButton = qtyControls.data('originalButton');
//                     qtyControls.remove();
//                     originalButton.show();
//                     removeFromCart(product_id);
//                 } else {
//                     var newVal = currentVal - 1;
//                     $input.val(newVal);
//                     updateCartQuantity(product_id, newVal);
//                 }
//             });
//         }
//
//         // 2.5 AJAX: Update cart quantity
//         function updateCartQuantity(product_id, quantity) {
//             $.ajax({
//                 url: wc_add_to_cart_params.ajax_url,
//                 method: 'POST',
//                 data: {
//                     action: 'custom_update_cart_quantity',
//                     product_id: product_id,
//                     quantity: quantity
//                 },
//                 success: function(response) {
//                     if ( response.success ) {
//                         $(document.body).trigger('wc_fragment_refresh');
//                     } else {
//                         showError(response.data ? response.data : "Unable to update quantity.");
//                         location.reload();
//                     }
//                 }
//             });
//         }
//
//         // 2.6 AJAX: Remove product
//         function removeFromCart(product_id) {
//             $.ajax({
//                 url: wc_add_to_cart_params.ajax_url,
//                 method: 'POST',
//                 data: {
//                     action: 'custom_remove_from_cart',
//                     product_id: product_id
//                 },
//                 success: function(response) {
//                     if ( response.success ) {
//                         $(document.body).trigger('wc_fragment_refresh');
//                     } else {
//                         showError("Unable to remove product from cart.");
//                     }
//                 }
//             });
//         }
//
//     });
//     </script>
//     <?php
//     endif;
// }
//
//
// /* ----------------------------------------------------------------------------
//    3. SINGLE PRODUCT PAGE: LIMIT TO MAX=2, SHOW ERROR IF EXCEEDED
// ---------------------------------------------------------------------------- */
//
// /* ----------------------------------------------------------------------------
//    3. SINGLE PRODUCT PAGE: LIMIT TO MAX=2, SHOW ERROR IF EXCEEDED
// ---------------------------------------------------------------------------- */
// /* ----------------------------------------------------------------------------
//    SINGLE PRODUCT PAGE: DYNAMICALLY LIMIT QUANTITY BASED ON GLOBAL CART TOTAL
// ---------------------------------------------------------------------------- */
// add_action('wp_footer', 'modified_single_product_cart_limit_handler');
// function modified_single_product_cart_limit_handler() {
//     if ( is_product() ) : ?>
//     <script type="text/javascript">
//     jQuery(document).ready(function($) {
//
//         // Utility function to show error messages in the global error container.
//         function showError(message) {
//             var $error = $('#custom-cart-error');
//             $error.text(message).addClass('show');
//             setTimeout(function() {
//                 $error.removeClass('show');
//             }, 3000);
//         }
//
//         // Get current cart items via AJAX
//         $.ajax({
//             url: wc_add_to_cart_params.ajax_url,
//             method: 'POST',
//             data: { action: 'get_cart_items' },
//             success: function(response) {
//                 var currentCartTotal = 0;
//                 // Sum the quantities already in the cart
//                 response.forEach(function(item) {
//                     currentCartTotal += parseInt(item.quantity);
//                 });
//                 // Determine allowed maximum for this product
//                 var allowedMax = 2 - currentCartTotal;
//                 var $qtyInput = $('form.cart .quantity .qty');
//
//                 if ( allowedMax <= 0 ) {
//                     // Cart is full; disable add-to-cart and quantity input.
//                     $('.single_add_to_cart_button').prop('disabled', true);
//                     $qtyInput.prop('disabled', true);
//                     showError("Maximum cart limit reached. You cannot add more items.");
//                 } else {
//                     // Update the quantity input's max attribute
//                     $qtyInput.attr('max', allowedMax);
//                     // Ensure the current value does not exceed the allowed maximum.
//                     if ( parseInt($qtyInput.val()) > allowedMax ) {
//                         $qtyInput.val(allowedMax);
//                         showError("Maximum quantity allowed is " + allowedMax + ".");
//                     }
//                 }
//             }
//         });
//
//         // Validate user input when they change the quantity
//         $('form.cart .quantity .qty').on('input change', function() {
//             var currentVal = parseInt($(this).val()) || 1;
//             var allowedMax = parseInt($(this).attr('max')) || 2;
//             if ( currentVal > allowedMax ) {
//                 $(this).val(allowedMax);
//                 showError("Maximum quantity allowed is " + allowedMax + ".");
//             }
//         });
//
//         // Check quantity on clicking Add to Cart
//         $('.single_add_to_cart_button').on('click', function(e) {
//             var $qtyInput = $('form.cart .quantity .qty');
//             var currentVal = parseInt($qtyInput.val()) || 1;
//             var allowedMax = parseInt($qtyInput.attr('max')) || 2;
//             if ( currentVal > allowedMax ) {
//                 e.preventDefault();
//                 showError("Maximum quantity allowed is " + allowedMax + ".");
//                 return false;
//             }
//             // If valid, allow normal submission; backend hooks will enforce the limit globally.
//         });
//     });
//     </script>
//     <?php
//     endif;
// }
//
//
//
//
//
//
// /* ----------------------------------------------------------------------------
//    4. AJAX BACKEND: GET/UPDATE/REMOVE CART ITEMS
// ---------------------------------------------------------------------------- */
// /** 4.1 Get Cart Items */
// add_action('wp_ajax_get_cart_items', 'get_cart_items');
// add_action('wp_ajax_nopriv_get_cart_items', 'get_cart_items');
// function get_cart_items() {
//     $cart_items = array();
//     foreach ( WC()->cart->get_cart() as $cart_item ) {
//         $cart_items[] = array(
//             'id'       => $cart_item['product_id'],
//             'quantity' => $cart_item['quantity']
//         );
//     }
//     wp_send_json( $cart_items );
// }
//
// /** 4.2 Update Cart Quantity */
// add_action('wp_ajax_custom_update_cart_quantity', 'custom_update_cart_quantity');
// add_action('wp_ajax_nopriv_custom_update_cart_quantity', 'custom_update_cart_quantity');
// function custom_update_cart_quantity() {
//     if ( ! isset( $_POST['product_id'], $_POST['quantity'] ) ) {
//         wp_send_json_error( 'Invalid request' );
//     }
//
//     $product_id = intval( $_POST['product_id'] );
//     $quantity   = intval( $_POST['quantity'] );
//     $quantity   = max(1, min(2, $quantity)); // per-product min/max
//
//     $other_total = 0;
//     $target_cart_item_key = false;
//
//     foreach ( WC()->cart->get_cart() as $cart_item_key => $cart_item ) {
//         if ( $cart_item['product_id'] === $product_id ) {
//             $target_cart_item_key = $cart_item_key;
//         } else {
//             $other_total += $cart_item['quantity'];
//         }
//     }
//
//     if ( ! $target_cart_item_key ) {
//         wp_send_json_error( 'Product not found in cart' );
//     }
//
//     // Enforce global limit of 2
//     if ( $other_total + $quantity > 2 ) {
//         wp_send_json_error( 'Maximum cart limit reached. You can only have 2 items in total.' );
//     }
//
//     WC()->cart->set_quantity( $target_cart_item_key, $quantity );
//     WC()->cart->calculate_totals();
//     wp_send_json_success();
// }
//
// /** 4.3 Remove Product */
// add_action('wp_ajax_custom_remove_from_cart', 'custom_remove_from_cart');
// add_action('wp_ajax_nopriv_custom_remove_from_cart', 'custom_remove_from_cart');
// function custom_remove_from_cart() {
//     if ( ! isset( $_POST['product_id'] ) ) {
//         wp_send_json_error( 'Invalid request' );
//     }
//     $product_id = intval( $_POST['product_id'] );
//     foreach ( WC()->cart->get_cart() as $cart_item_key => $cart_item ) {
//         if ( $cart_item['product_id'] === $product_id ) {
//             WC()->cart->remove_cart_item( $cart_item_key );
//             WC()->cart->calculate_totals();
//             wp_send_json_success();
//         }
//     }
//     wp_send_json_error( 'Product not found in cart' );
// }
//
//
// add_filter( 'woocommerce_add_to_cart_validation', 'nmri_restrict_cart_add_for_guests', 10, 3 );
// function nmri_restrict_cart_add_for_guests( $passed, $product_id, $quantity ) {
//     // If user is not logged in, block the add-to-cart
//     if ( ! is_user_logged_in() ) {
//         // Add an error notice for non-AJAX
//         wc_add_notice( __( 'Please log in to add items to your cart.', 'your-textdomain' ), 'error' );
//         return false;
//     }
//
//     // Otherwise allow normal validation to continue
//     return $passed;
// }
//
//
// /* ----------------------------------------------------------------------------
//    5. WOOCOMMERCE HOOKS: STRICT GLOBAL LIMIT OF 2
// ---------------------------------------------------------------------------- */
// // Prevent adding more than 2 total items
// add_filter( 'woocommerce_add_to_cart_validation', 'restrict_cart_total_quantity', 10, 3 );
// function restrict_cart_total_quantity( $passed, $product_id, $quantity ) {
//     $cart = WC()->cart;
//     $current_total = 0;
//     foreach ( $cart->get_cart() as $cart_item ) {
//         $current_total += $cart_item['quantity'];
//     }
//     if ( ( $current_total + $quantity ) > 2 ) {
//         wc_add_notice( __('You can only have a total of 2 items in your cart.', 'textdomain'), 'error' );
//         return false;
//     }
//     return $passed;
// }
//
// // Prevent updating cart if new total exceeds 2
// add_filter( 'woocommerce_update_cart_validation', 'restrict_cart_update_quantity', 10, 4 );
// function restrict_cart_update_quantity( $passed, $cart_item_key, $values, $quantity ) {
//     $cart = WC()->cart;
//     $new_total = 0;
//     foreach ( $cart->get_cart() as $key => $cart_item ) {
//         $new_total += ( $key === $cart_item_key ) ? $quantity : $cart_item['quantity'];
//     }
//     if ( $new_total > 2 ) {
//         wc_add_notice( __('You can only have a total of 2 items in your cart.', 'textdomain'), 'error' );
//         return false;
//     }
//     return $passed;
// }
//
// // Force cart update if total exceeds 2 (removes excess automatically)
// add_action( 'woocommerce_check_cart_items', 'force_cart_quantity_limit' );
// function force_cart_quantity_limit() {
//     $cart = WC()->cart;
//     $total_quantity = 0;
//     foreach ( $cart->get_cart() as $cart_item ) {
//         $total_quantity += $cart_item['quantity'];
//     }
//     if ( $total_quantity > 2 ) {
//         wc_add_notice( __('Your cart can only contain 2 items. Excess items have been removed.', 'textdomain'), 'error' );
//         foreach ( $cart->get_cart() as $cart_item_key => $cart_item ) {
//             if ( $total_quantity > 2 ) {
//                 $new_quantity = max( 2 - ($total_quantity - $cart_item['quantity']), 0 );
//                 WC()->cart->set_quantity( $cart_item_key, $new_quantity );
//                 $total_quantity -= ( $cart_item['quantity'] - $new_quantity );
//             }
//         }
//     }
// }
//
//
// /* ----------------------------------------------------------------------------
//    6. PASSWORD VISIBILITY TOGGLE
// ---------------------------------------------------------------------------- */
// add_action('wp_footer', 'add_password_visibility_toggle');
// function add_password_visibility_toggle() {
//     ?>
//     <script type="text/javascript">
//     document.addEventListener("DOMContentLoaded", function () {
//         let passwordFields = document.querySelectorAll("input[type='password']");
//         passwordFields.forEach(function (field) {
//             let wrapper = document.createElement("div");
//             wrapper.style.position = "relative";
//             field.parentNode.insertBefore(wrapper, field);
//             wrapper.appendChild(field);
//
//             let toggleBtn = document.createElement("span");
//             toggleBtn.innerHTML = "👁";
//             toggleBtn.style.position = "absolute";
//             toggleBtn.style.right = "10px";
//             toggleBtn.style.top = "50%";
//             toggleBtn.style.transform = "translateY(-50%)";
//             toggleBtn.style.cursor = "pointer";
//             wrapper.appendChild(toggleBtn);
//
//             toggleBtn.addEventListener("click", function () {
//                 if (field.type === "password") {
//                     field.type = "text";
//                     toggleBtn.innerHTML = "👁‍🗨";
//                 } else {
//                     field.type = "password";
//                     toggleBtn.innerHTML = "👁";
//                 }
//             });
//         });
//     });
//     </script>
//     <?php
// }
//
//
// /* ----------------------------------------------------------------------------
//    7. EXISTING EMAIL CHECK SCRIPT
// ---------------------------------------------------------------------------- */
// add_action('wp_footer', 'add_existing_email_check_script');
// function add_existing_email_check_script() {
//     ?>
//     <script type="text/javascript">
//     jQuery(document).ready(function($) {
//         $('#reg_email').on('blur', function() {
//             var email = $(this).val();
//             var emailField = $(this);
//             $('.email-error-message').remove();
//             if (email) {
//                 $.ajax({
//                     url: "<?php echo admin_url('admin-ajax.php'); ?>",
//                     type: 'POST',
//                     data: {
//                         action: 'check_existing_email',
//                         email: email
//                     },
//                     success: function(response) {
//                         if (response === 'exists') {
//                             emailField.after('<p class="email-error-message" style="color: red; font-size: 14px;">❌ This email is already registered. <a href="/my-account/">Login here</a></p>');
//                             emailField.css("border", "2px solid red");
//                         } else {
//                             emailField.css("border", "2px solid green");
//                         }
//                     }
//                 });
//             }
//         });
//     });
//     </script>
//     <?php
// }
//
// /**
//  * Enforce global cart limit when adding products.
//  *
//  * Blocks adding new items if the cart (plus the quantity being added)
//  * would exceed 2 items total.
//  */
// function enforce_global_cart_limit_on_add_to_cart( $passed, $product_id, $quantity ) {
//     // Get current cart items
//     $cart = WC()->cart->get_cart();
//     $total_qty = 0;
//     foreach ( $cart as $item ) {
//         $total_qty += $item['quantity'];
//     }
//
//     if ( $total_qty + $quantity > 2 ) {
//         wc_add_notice( 'You can only add a maximum of 2 items in your cart.', 'error' );
//         return false;
//     }
//     return $passed;
// }
// add_filter( 'woocommerce_add_to_cart_validation', 'enforce_global_cart_limit_on_add_to_cart', 10, 3 );
//
//
// /**
//  * Enforce global cart limit on updates before calculating totals.
//  *
//  * If the total quantity in the cart exceeds 2 (for example, by updating a product’s quantity via AJAX),
//  * this function displays an error notice and then resets the cart so that only 2 items remain.
//  *
//  * For this example, we keep only the first two items (each set to quantity 1)
//  * and remove any additional items.
//  */
// function enforce_global_cart_limit_before_calculate_totals( $cart ) {
//     if ( is_admin() && ! defined( 'DOING_AJAX' ) ) {
//         return;
//     }
//
//     // Calculate total quantity in cart.
//     $total_qty = 0;
//     foreach( $cart->get_cart() as $cart_item ) {
//         $total_qty += $cart_item['quantity'];
//     }
//
//     // If total exceeds 2, add an error notice and adjust the cart.
//     if ( $total_qty > 2 ) {
//         wc_add_notice( 'Your cart cannot have more than 2 items. Extra items have been removed.', 'error' );
//
//         // We'll keep the first two items encountered (each set to quantity 1)
//         $count = 0;
//         foreach( $cart->get_cart() as $cart_item_key => $cart_item ) {
//             if ( $count < 2 ) {
//                 // Set each allowed item to quantity 1.
//                 WC()->cart->set_quantity( $cart_item_key, 1, true );
//                 $count++;
//             } else {
//                 // Remove any extra items.
//                 WC()->cart->remove_cart_item( $cart_item_key );
//             }
//         }
//     }
// }
// add_action( 'woocommerce_before_calculate_totals', 'enforce_global_cart_limit_before_calculate_totals', 20, 1 );
//
//
// /**
//  * AJAX endpoint to update a cart item's quantity, enforcing a global limit of 2 items.
//  *
//  * This function recalculates the total quantity by looping through all items in the cart,
//  * replacing the quantity of the updated item with the new quantity. If the new total exceeds 2,
//  * an error is returned.
//  */
// function ajax_update_cart() {
//     if ( ! isset( $_POST['cart_item_key'], $_POST['quantity'] ) ) {
//         wp_send_json_error( array( 'message' => 'Invalid request.' ) );
//     }
//
//     $cart_item_key = sanitize_text_field( $_POST['cart_item_key'] );
//     $new_qty       = absint( $_POST['quantity'] );
//
//     $cart = WC()->cart->get_cart();
//     if ( ! isset( $cart[ $cart_item_key ] ) ) {
//         wp_send_json_error( array( 'message' => 'Cart item not found.' ) );
//     }
//
//     // Calculate the total quantity if this update is applied.
//     $total_qty = 0;
//     foreach ( $cart as $key => $item ) {
//         if ( $key === $cart_item_key ) {
//             $total_qty += $new_qty;
//         } else {
//             $total_qty += $item['quantity'];
//         }
//     }
//
//     if ( $total_qty > 2 ) {
//         wp_send_json_error( array( 'message' => 'Maximum cart limit of 2 items exceeded.' ) );
//     }
//
//     WC()->cart->set_quantity( $cart_item_key, $new_qty, true );
//     WC()->cart->calculate_totals();
//
//     $updated_cart = WC()->cart->get_cart();
//     $cart_item    = $updated_cart[ $cart_item_key ];
//     $new_subtotal = WC()->cart->get_product_subtotal( $cart_item['data'], $cart_item['quantity'] );
//
//     wp_send_json_success( array(
//          'message'       => 'Cart updated successfully.',
//          'new_subtotal'  => $new_subtotal,
//          'cart_subtotal' => WC()->cart->get_cart_subtotal(),
//          'cart_total'    => WC()->cart->get_cart_total(),
//     ) );
// }
// add_action( 'wp_ajax_ajax_update_cart', 'ajax_update_cart' );
// add_action( 'wp_ajax_nopriv_ajax_update_cart', 'ajax_update_cart' );
//
//
// /**
//  * AJAX endpoint to remove a cart item.
//  */
// function ajax_remove_cart_item() {
//     if ( ! isset( $_POST['cart_item_key'] ) ) {
//         wp_send_json_error( array( 'message' => 'Invalid request.' ) );
//     }
//
//     $cart_item_key = sanitize_text_field( $_POST['cart_item_key'] );
//     WC()->cart->remove_cart_item( $cart_item_key );
//     WC()->cart->calculate_totals();
//
//     wp_send_json_success( array(
//          'message'       => 'Item removed.',
//          'cart_subtotal' => WC()->cart->get_cart_subtotal(),
//          'cart_total'    => WC()->cart->get_cart_total(),
//     ) );
// }
// add_action( 'wp_ajax_ajax_remove_cart_item', 'ajax_remove_cart_item' );
// add_action( 'wp_ajax_nopriv_ajax_remove_cart_item', 'ajax_remove_cart_item' );
//
//
//
// function restrict_checkout_states_to_karnataka($states) {
//     $states['IN'] = array( // 'IN' is the country code for India
//         'KA' => 'Karnataka',
//     );
//     return $states;
// }
// add_filter('woocommerce_states', 'restrict_checkout_states_to_karnataka');
//
//
//
// // Add custom fields for product serviceable location in WooCommerce
// add_action('woocommerce_product_options_general_product_data', 'add_service_area_fields');
// function add_service_area_fields() {
//     // Single pincode field
//     woocommerce_wp_text_input( array(
//         'id'          => '_serviceable_pincode',
//         'label'       => __('Serviceable Pincode', 'woocommerce'),
//         'desc_tip'    => true,
//         'description' => __('Enter the pincode (e.g., 560093).', 'woocommerce'),
//     ) );
//
//     // Multi-select for serviceable areas
//     $areas = array(
//          'SG Palya'       => __('SG Palya', 'woocommerce'),
// //          'GM Palya'       => __('GM Palya', 'woocommerce'),
//           'Kaggadasapura'  => __('Kaggadasapura', 'woocommerce'),
//           'New Thippasandra'  => __('New Tippasandra', 'woocommerce'),
//           'Indira Nagar'  => __('Indira Nagar', 'woocommerce'),
//     );
//     $current = get_post_meta(get_the_ID(), '_serviceable_areas', true); // comma-separated
//     $current_arr = $current ? explode(',', $current) : array();
//     ?>
//     <p class="form-field">
//       <label for="serviceable_areas"><?php _e('Serviceable Areas', 'woocommerce'); ?></label>
//       <select id="serviceable_areas" name="serviceable_areas[]" multiple="multiple" style="width:50%;">
//       <?php
//       foreach ($areas as $key => $value) {
//           $selected = in_array($key, $current_arr) ? 'selected="selected"' : '';
//           echo '<option value="' . esc_attr($key) . '" ' . $selected . '>' . esc_html($value) . '</option>';
//       }
//       ?>
//       </select>
//       <span class="description"><?php _e('Hold Ctrl (Cmd on Mac) to select multiple areas.', 'woocommerce'); ?></span>
//     </p>
//     <?php
// }
//
// // Save the custom fields
// add_action('woocommerce_process_product_meta', 'save_service_area_fields');
// function save_service_area_fields($post_id) {
//     if (isset($_POST['_serviceable_pincode'])) {
//         update_post_meta($post_id, '_serviceable_pincode', sanitize_text_field($_POST['_serviceable_pincode']));
//     }
//     if (isset($_POST['serviceable_areas'])) {
//         $areas = array_map('sanitize_text_field', $_POST['serviceable_areas']);
//         $areas_string = implode(',', $areas);
//         update_post_meta($post_id, '_serviceable_areas', $areas_string);
//     }
// }
// add_action('pre_get_posts', 'filter_products_by_location');
// function filter_products_by_location($query) {
//     if (!is_admin() && $query->is_main_query() && (is_shop() || is_product_category() || is_product_tag())) {
//         if (isset($_COOKIE['user_pincode']) && isset($_COOKIE['user_area'])) {
//             $user_pincode = sanitize_text_field($_COOKIE['user_pincode']);
//             $user_area    = sanitize_text_field($_COOKIE['user_area']);
//             $meta_query = $query->get('meta_query');
//             if (!is_array($meta_query)) {
//                 $meta_query = array();
//             }
//             // Must match the pincode exactly AND user_area must appear in the multi-select string
//             $meta_query[] = array(
//                 'relation' => 'AND',
//                 array(
//                     'key'     => '_serviceable_pincode',
//                     'value'   => $user_pincode,
//                     'compare' => '='
//                 ),
//                 array(
//                     'key'     => '_serviceable_areas',
//                     'value'   => $user_area,
//                     'compare' => 'LIKE'
//                 )
//             );
//             $query->set('meta_query', $meta_query);
//         }
//     }
// }
// // Add area-specific pricing fields
// add_action('woocommerce_product_options_pricing', 'add_area_specific_price_fields');
// function add_area_specific_price_fields() {
//     woocommerce_wp_text_input( array(
//         'id'          => '_price_sg_palya',
//         'label'       => __('Price for SG Palya', 'woocommerce'),
//         'type'        => 'number',
//         'desc_tip'    => true,
//         'description' => __('Price for SG Palya (leave empty for regular price).', 'woocommerce'),
//     ) );
//     woocommerce_wp_text_input( array(
//         'id'          => '_price_gm_palya',
//         'label'       => __('Price for GM Palya', 'woocommerce'),
//         'type'        => 'number',
//         'desc_tip'    => true,
//         'description' => __('Price for GM Palya (leave empty for regular price).', 'woocommerce'),
//     ) );
//     woocommerce_wp_text_input( array(
//         'id'          => '_price_kaggadasapura',
//         'label'       => __('Price for Kaggadasapura', 'woocommerce'),
//         'type'        => 'number',
//         'desc_tip'    => true,
//         'description' => __('Price for Kaggadasapura (leave empty for regular price).', 'woocommerce'),
//     ) );
// 	woocommerce_wp_text_input( array(
//         'id'          => '_price_New_Tippasandra',
//         'label'       => __('Price for New Tippasandra', 'woocommerce'),
//         'type'        => 'number',
//         'desc_tip'    => true,
//         'description' => __('Price for  New Tippasandra (leave empty for regular price).', 'woocommerce'),
//     ) );
// 	woocommerce_wp_text_input( array(
//         'id'          => '_price_Indira_Nagar',
//         'label'       => __('Price for Indira Nagar', 'woocommerce'),
//         'type'        => 'number',
//         'desc_tip'    => true,
//         'description' => __('Price for  Indira Nagar (leave empty for regular price).', 'woocommerce'),
//     ) );
// }
// add_action('woocommerce_process_product_meta', 'save_area_specific_price_fields');
// function save_area_specific_price_fields($post_id) {
//     if (isset($_POST['_price_sg_palya'])) {
//         update_post_meta($post_id, '_price_sg_palya', sanitize_text_field($_POST['_price_sg_palya']));
//     }
//     if (isset($_POST['_price_gm_palya'])) {
//         update_post_meta($post_id, '_price_gm_palya', sanitize_text_field($_POST['_price_gm_palya']));
//     }
//     if (isset($_POST['_price_kaggadasapura'])) {
//         update_post_meta($post_id, '_price_kaggadasapura', sanitize_text_field($_POST['_price_kaggadasapura']));
//     }
// 	if (isset($_POST['_price_New_Tippasandra'])) {
//         update_post_meta($post_id, '_price_New_Tippasandra', sanitize_text_field($_POST['_price_New_Tippasandra']));
//     }
// 	if (isset($_POST['_price_Indira_Nagar'])) {
//         update_post_meta($post_id, '_price_Indira_Nagar', sanitize_text_field($_POST['_price_Indira_Nagar']));
//     }
// }
// // Filter product price by user's area
// add_filter('woocommerce_product_get_price', 'apply_area_specific_price', 10, 2);
// add_filter('woocommerce_product_get_regular_price', 'apply_area_specific_price', 10, 2);
// function apply_area_specific_price($price, $product) {
//     if (isset($_COOKIE['user_area'])) {
//         $user_area = sanitize_text_field($_COOKIE['user_area']);
//         if ($user_area === 'SG Palya') {
//             $area_price = get_post_meta($product->get_id(), '_price_sg_palya', true);
//         } elseif ($user_area === 'GM Palya') {
//             $area_price = get_post_meta($product->get_id(), '_price_gm_palya', true);
//         } elseif ($user_area === 'Kaggadasapura') {
//             $area_price = get_post_meta($product->get_id(), '_price_kaggadasapura', true);
//         } elseif ($user_area === 'New Thippasandra') {
//             $area_price = get_post_meta($product->get_id(), '_price_New_Tippasandra', true);
//         } elseif ($user_area === 'Indira Nagar') {
//             $area_price = get_post_meta($product->get_id(), '_price_Indira_Nagar', true);
//         }
//         if (!empty($area_price)) {
//             return $area_price;
//         }
//     }
//     return $price;
// }
// // Enqueue script on checkout to autofill the billing postcode field
// add_action('wp_enqueue_scripts', 'enqueue_autofill_pincode_script');
// function enqueue_autofill_pincode_script() {
//     if (is_checkout()) {
//         wp_enqueue_script('autofill-pincode', get_stylesheet_directory_uri() . '/js/autofill-pincode.js', array('jquery'), null, true);
//     }
// }
//
//
//
// function add_whatsapp_button_below_street_address() {
//     // Build the WhatsApp link using a filter so the number can be changed.
//     $whatsapp_number = apply_filters( 'wc_whatsapp_number', '1234567890' ); // Default dummy number
//     $default_message = "Hi, I'm here. Can you please share your location?";
//     $whatsapp_link = 'https://wa.me/' . $whatsapp_number . '?text=' . urlencode( $default_message );
//     ?>
//     <script type="text/javascript">
//         jQuery(document).ready(function($){
//             // Build the button HTML.
//             var whatsappLink = '<?php echo esc_js( $whatsapp_link ); ?>';
//             var buttonHTML = '<div class="share-location-container" style="margin:10px 0 20px; text-align:left;">' +
//                 '<a href="'+whatsappLink+'" target="_blank" class="button share-location-button" ' +
//                 'style="background-color:#25D366; border:none; color:#fff; padding:10px 20px; border-radius:5px; text-decoration:none; font-size:16px;">' +
//                 'Share Location via WhatsApp</a></div>';
//             // Insert the button after the street address field container.
//             $("#billing_address_1_field").after(buttonHTML);
//         });
//     </script>
//     <?php
// }
// // add_action( 'woocommerce_after_checkout_billing_form', 'add_whatsapp_button_below_street_address' );
// /**
//  * Validate that the checkout address matches the user's selected pincode & area.
//  */
// add_action('woocommerce_after_checkout_validation', 'validate_user_location_at_checkout', 10, 2);
// function validate_user_location_at_checkout($data, $errors) {
//     // Retrieve the user's saved pincode & area from cookies
//     $cookie_pincode = isset($_COOKIE['user_pincode']) ? sanitize_text_field($_COOKIE['user_pincode']) : '';
//     $cookie_area    = isset($_COOKIE['user_area']) ? sanitize_text_field($_COOKIE['user_area']) : '';
//
//
//
//         // Compare the checkout city/area to the saved area
//         // If you want an exact match, use "!=="
//         // If you want partial match (e.g. user might type "Kaggadasapura, near ABC"), use stripos:
//         if (!empty($data['billing_city'])) {
//             // Example: partial match check
//
//             }
//         }
//
//
// // Add "Select Your Area" field to the checkout form
// add_filter('woocommerce_checkout_fields', 'custom_add_billing_area_field');
// function custom_add_billing_area_field($fields) {
// 	$cookie_pincode = isset($_COOKIE['user_pincode']) ? sanitize_text_field($_COOKIE['user_pincode']) : '';
//     $pincode_to_areas = array(
//         '560093' => array(
//             'SG Palya'	=>	__('SG Palya', 'woocommerce'),
//             'Kaggadasapura'	=>	__('Kaggadasapura', 'woocommerce'),
//         ),
//         '560075' => array(
//             'New Thippasandra' => __('New Thippasandra', 'woocommerce'),
//         ),
// 		'560008' => array(
//             'Indira Nagar' => __('Indira Nagar', 'woocommerce'),
//         )
//     );
//
//     $area_options = array('' => __('-- Choose an Area --', 'woocommerce'));
//     // Add areas for the current pincode if found
//     if (!empty($cookie_pincode) && isset($pincode_to_areas[$cookie_pincode])) {
//         $area_options = array_merge($area_options, $pincode_to_areas[$cookie_pincode]);
//     }
//     $fields['billing']['billing_area'] = array(
//         'type'        => 'select',
//         'label'       => __('Select Your Area', 'woocommerce'),
//         'required'    => true,
//         'options'     => $area_options,
//         'class'       => array('form-row-wide'),
//         'clear'       => true,
//         'priority'    => 110,
//     );
//     return $fields;
// }
// add_action('wp_enqueue_scripts', 'enqueue_checkout_area_script');
// function enqueue_checkout_area_script() {
//     if (is_checkout()) {
//         wp_enqueue_script(
//             'checkout-area',
//             get_stylesheet_directory_uri() . '/js/checkout-area.js',
//             array('jquery'),
//             null,
//             true
//         );
//     }
// }
//
// if ( ! function_exists('apply_area_specific_price_custom') ) {
//     add_filter('woocommerce_product_get_price', 'apply_area_specific_price_custom', 10, 2);
//     add_filter('woocommerce_product_get_regular_price', 'apply_area_specific_price_custom', 10, 2);
//     function apply_area_specific_price_custom($price, $product) {
//         if (isset($_COOKIE['user_area'])) {
//             $user_area = sanitize_text_field($_COOKIE['user_area']);
//             if ($user_area === 'SG Palya') {
//                 $area_price = get_post_meta($product->get_id(), '_price_sg_palya', true);
//             } elseif ($user_area === 'GM Palya') {
//                 $area_price = get_post_meta($product->get_id(), '_price_gm_palya', true);
//             } elseif ($user_area === 'Kaggadasapura') {
//                 $area_price = get_post_meta($product->get_id(), '_price_kaggadasapura', true);
// 			} elseif ($user_area === 'New Tippasandra') {
//                 $area_price = get_post_meta($product->get_id(), '_price_New_Tippasandra', true);
//             } elseif ($user_area === 'Indira Nagar') {
//                 $area_price = get_post_meta($product->get_id(), '_price_Indira_Nagar', true);
//             }
//             if (!empty($area_price)) {
//                 return $area_price;
//             }
//         }
//         return $price;
//     }
// }
// function custom_mobile_menu_items( $items, $args ) {
//     // Log when this function is triggered
//     error_log('custom_mobile_menu_items triggered. Theme location: ' . ( isset( $args->theme_location ) ? $args->theme_location : 'undefined' ));
//
//     // Check if this is the mobile menu using theme location or menu name
//     if ( ( isset( $args->theme_location ) && $args->theme_location === 'mobile-menu' ) ||
//          ( isset( $args->menu ) && $args->menu === 'mobile-menu' ) ) {
//
//         // Debug log: check if user is logged in
//         error_log('Mobile menu detected. User logged in? ' . ( is_user_logged_in() ? 'Yes' : 'No' ));
//
//         // Define inline CSS for the <a> tag and the list items
//         $link_style = 'style="font-family:\'Montserrat\', sans-serif; font-size:18px; text-transform:uppercase; color:black;"';
//         $li_style   = 'style="display:block; margin-bottom:10px; margin-top:20px;"';
//
//         if ( is_user_logged_in() ) {
//             // For logged-in users, append Wishlist and Cart links
//             $wishlist_url = site_url( '/wishlist/' );
//             $cart_url     = wc_get_cart_url();
//
//             $items .= '<li class="menu-item custom-mobile-item" ' . $li_style . '>';
//             $items .= '<a href="' . esc_url( $wishlist_url ) . '" ' . $link_style . '>Wishlist</a>';
//             $items .= '</li>';
//
//             $items .= '<li class="menu-item custom-mobile-item" ' . $li_style . '>';
//             $items .= '<a href="' . esc_url( $cart_url ) . '" ' . $link_style . '>Cart</a>';
//             $items .= '</li>';
//
//             // Log appended links for debugging
//             error_log('Appended Wishlist and Cart links.');
//         } else {
//             // For guests, append a My Account link only if it's not already present
//             if ( false === strpos( $items, 'My Account' ) ) {
//                 $login_url = 'https://demo.nammaniru.in/login/';
//                 $items .= '<li class="menu-item custom-mobile-item" ' . $li_style . '>';
//                 $items .= '<a href="' . esc_url( $login_url ) . '" ' . $link_style . '>My Account</a>';
//                 $items .= '</li>';
//                 error_log('Appended My Account link for guest.');
//             }
//         }
//     }
//     return $items;
// }
// add_filter( 'wp_nav_menu_items', 'custom_mobile_menu_items', 10, 2 );
// // Redirect non-logged-in users to login when adding a product to the cart.
// add_filter( 'woocommerce_add_to_cart_validation', 'redirect_non_logged_in_users_add_to_cart', 10, 3 );
// function redirect_non_logged_in_users_add_to_cart( $passed, $product_id, $quantity ) {
//     if ( ! is_user_logged_in() ) {
//         // For AJAX requests, send a JSON response with the redirect URL.
//         if ( wp_doing_ajax() ) {
//             wp_send_json( array(
//                 'error'    => true,
//                 'redirect' => site_url( '/login' )
//             ) );
//             wp_die();
//         } else {
//             // For non-AJAX requests, perform a safe redirect.
//             wp_safe_redirect( site_url( '/login' ) );
//             exit;
//         }
//     }
//     return $passed;
// }
// add_filter( 'woocommerce_logout_url', 'custom_woocommerce_logout_url' );
// function custom_woocommerce_logout_url( $logout_url ) {
//     // Return the logout URL with your custom redirect
//     return wc_logout_url( 'https://demo.nammaniru.in/login' );
// }
// add_action('wp_logout','auto_redirect_external_after_logout');
//
// function auto_redirect_external_after_logout(){
//
//   wp_redirect('https://demo.nammaniru.in/login');
//   exit();
//
// }
// /**
//  * Clean solution to remove optional text from instant delivery without making it required
//  */
// add_filter('woocommerce_form_field_args', 'fix_instant_delivery_optional_display', 20, 3);
// function fix_instant_delivery_optional_display($args, $key, $value) {
//     if ('instant_delivery' === $key) {
//         // Keep it optional, but store original label without modification
//         $args['required'] = false;
//
//         if (isset($args['label'])) {
//             // Remove the class that WooCommerce uses to append (optional)
//             if (!isset($args['custom_attributes'])) {
//                 $args['custom_attributes'] = array();
//             }
//             $args['custom_attributes']['data-hide-optional'] = 'true';
//
//             // Store clean label
//             $args['label'] = str_replace(' (optional)', '', $args['label']);
//         }
//     }
//     return $args;
// }
//
// // Add CSS to prevent WooCommerce from showing optional text
// add_action('wp_head', 'hide_instant_delivery_optional_text');
// function hide_instant_delivery_optional_text() {
//     ?>
//     <style>
//         /* Hide only the optional text for instant delivery, not the whole field */
//         #instant_delivery_field .optional,
//         label[for="instant_delivery"] .optional {
//             display: none !important;
//         }
//     </style>
//     <?php
// }
//
// // Final filter to clean any remaining optional text from the rendered field
// add_filter('woocommerce_form_field_checkbox', 'clean_instant_delivery_optional_text', 99, 4);
// function clean_instant_delivery_optional_text($field, $key, $args, $value) {
//     if ('instant_delivery' === $key) {
//         $field = preg_replace('/<span class="optional">.*?<\/span>/', '', $field);
//         $field = str_replace(' (optional)', '', $field);
//     }
//     return $field;
// }
//
// /**
//  * WooCommerce Delivery Slots Customization
//  *
//  * This code adds delivery date, time slot, and instant delivery options to WooCommerce checkout
//  * with conditional logic for time slot availability based on the current time and selected date.
//  * It now also supports saving these fields when orders are created via the REST API.
//  */
//
// // Ensure direct file access is blocked.
// if ( ! defined( 'ABSPATH' ) ) {
// 	exit;
// }
//
// /**
//  * Enqueue jQuery UI Datepicker and custom JS.
//  */
// function custom_delivery_enqueue_scripts() {
// 	if ( is_checkout() ) {
// 		wp_enqueue_script( 'jquery-ui-datepicker' );
// 		wp_enqueue_style( 'jquery-ui-style', '//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css' );
//
// 		// Enqueue custom script for delivery slot functionality.
// 		wp_enqueue_script( 'custom-delivery-script', get_stylesheet_directory_uri() . '/js/custom-delivery.js', array( 'jquery', 'jquery-ui-datepicker' ), '1.0', true );
//
// 		// Localize data for JavaScript.
// 		$current_time  = current_time( 'H:i' );
// 		$current_date  = current_time( 'Y-m-d' );
// 		$tomorrow_date = date( 'Y-m-d', strtotime( $current_date . ' +1 day' ) );
//
// 		wp_localize_script( 'custom-delivery-script', 'delivery_data', array(
// 			'current_time'  => $current_time,
// 			'current_date'  => $current_date,
// 			'tomorrow_date' => $tomorrow_date,
// 			'time_slots'    => get_time_slots(),
// 			'ajax_url'      => admin_url( 'admin-ajax.php' )
// 		) );
// 	}
// }
// add_action( 'wp_enqueue_scripts', 'custom_delivery_enqueue_scripts' );
//
// add_action('woocommerce_checkout_update_order_meta', 'save_custom_delivery_fields');
// function save_custom_delivery_fields($order_id) {
//     if (!empty($_POST['delivery_date'])) {
//         update_post_meta($order_id, '_delivery_date', sanitize_text_field($_POST['delivery_date']));
//     }
//
//     if (!empty($_POST['delivery_time_slot'])) {
//         update_post_meta($order_id, '_delivery_time_slot', sanitize_text_field($_POST['delivery_time_slot']));
//     }
// }
//
//
// add_filter('woocommerce_rest_prepare_shop_order_object', 'add_custom_delivery_fields_to_api', 10, 3);
// function add_custom_delivery_fields_to_api($response, $order, $request) {
//     $delivery_date = get_post_meta($order->get_id(), '_delivery_date', true);
//     $delivery_time_slot = get_post_meta($order->get_id(), '_delivery_time_slot', true);
//
//     if (!empty($delivery_date)) {
//         $response->data['delivery_date'] = $delivery_date;
//     }
//
//     if (!empty($delivery_time_slot)) {
//         $response->data['delivery_time_slot'] = $delivery_time_slot;
//     }
//
//     return $response;
// }
//
// /**
//  * Create directory and file for custom debug logging if they don't exist.
//  */
// function ensure_custom_debug_log() {
// 	$log_file = ABSPATH . 'wp-content/custom-debug.log';
// 	if ( ! file_exists( $log_file ) ) {
// 		$dir = dirname( $log_file );
// 		if ( ! is_dir( $dir ) ) {
// 			mkdir( $dir, 0755, true );
// 		}
// 		file_put_contents( $log_file, "Custom Debug Log Initialized\n" );
// 	}
// }
//
// /**
//  * Custom debug logging function.
//  */
// function custom_debug_log( $message ) {
// 	ensure_custom_debug_log();
// 	$log_file  = ABSPATH . 'wp-content/custom-debug.log';
// 	$timestamp = current_time( 'Y-m-d H:i:s' );
// 	file_put_contents( $log_file, "[$timestamp] $message\n", FILE_APPEND );
// }
//
// /**
//  * Get time slot definitions.
//  */
// function get_time_slots() {
// 	return array(
// 		'09:00-12:00' => '9 AM - 12 PM',
// 		'12:00-15:00' => '12 PM - 3 PM',
// 		'15:00-18:00' => '3 PM - 6 PM',
// 		'18:00-21:00' => '6 PM - 9 PM'
// 	);
// }
//
// /**
//  * Get active time slots based on the selected date and current time.
//  *
//  * For today, only show a slot if the current time is before (slot start time minus 5 minutes).
//  */
// function get_active_time_slots( $selected_date ) {
// 	$time_slots   = get_time_slots();
// 	$current_date = current_time( 'Y-m-d' );
// 	$current_time = current_time( 'H:i' );
// 	$active_slots = array();
//
// 	custom_debug_log( "Selected date: $selected_date, Current date: $current_date, Current time: $current_time" );
//
// 	// If tomorrow is selected, show all slots regardless of current time.
// 	if ( $selected_date > $current_date ) {
// 		custom_debug_log( "Tomorrow selected, showing all slots" );
// 		return $time_slots;
// 	}
//
// 	// For today, only include slots if the current time is before (slot start time minus 5 minutes).
// 	$current_timestamp = strtotime( $current_time );
// 	foreach ( $time_slots as $time_range => $label ) {
// 		list( $start_time, $end_time ) = explode( '-', $time_range );
// 		$slot_start_timestamp = strtotime( $start_time );
// 		$cutoff_timestamp     = $slot_start_timestamp - ( 5 * 60 );
//
// 		if ( $current_timestamp < $cutoff_timestamp ) {
// 			$active_slots[ $time_range ] = $label;
// 			custom_debug_log( "Adding slot: $time_range ($label)" );
// 		} else {
// 			custom_debug_log( "Skipping slot: $time_range ($label) - Current time is past cutoff " . date( 'H:i', $cutoff_timestamp ) );
// 		}
// 	}
//
// 	return $active_slots;
// }
//
// /**
//  * Check if instant delivery is available based on current time.
//  */
// function is_instant_delivery_available() {
// 	$time_slots       = get_time_slots();
// 	$current_time     = current_time( 'H:i' );
// 	$current_timestamp = strtotime( $current_time );
//
// 	foreach ( $time_slots as $time_range => $label ) {
// 		list( $start_time, $end_time ) = explode( '-', $time_range );
// 		$slot_start_timestamp = strtotime( $start_time );
// 		$slot_end_timestamp   = strtotime( $end_time );
// 		// Check if current time is within a slot (with a 5-minute buffer before the slot ends).
// 		$end_time_minus_5min_timestamp = $slot_end_timestamp - ( 30 * 60 );
//
// 		if ( $current_timestamp >= $slot_start_timestamp && $current_timestamp <= $end_time_minus_5min_timestamp ) {
// 			return array(
// 				'available'    => true,
// 				'current_slot' => $label
// 			);
// 		}
// 	}
//
// 	return array(
// 		'available'    => false,
// 		'current_slot' => ''
// 	);
// }
//
// /**
//  * Add delivery fields to the checkout page.
//  */
// function add_delivery_fields( $checkout ) {
// 	$time_slots       = get_time_slots();
// 	$current_date     = current_time( 'Y-m-d' );
// 	$tomorrow_date    = date( 'Y-m-d', strtotime( $current_date . ' +1 day' ) );
// 	$instant_delivery = is_instant_delivery_available();
//
// 	echo '<div id="delivery_fields" style="clear:both;">';
// 	echo '<h3>' . __( 'Delivery Options' ) . '</h3>';
//
// 	// Delivery Date Field.
// 	woocommerce_form_field( 'delivery_date', array(
// 		'type'              => 'text',
// 		'class'             => array( 'delivery-date-field' ),
// 		'label'             => __( 'Delivery Date' ),
// 		'placeholder'       => __( 'Select a date' ),
// 		'required'          => true,
// 		'custom_attributes' => array(
// 			'autocomplete' => 'off',
// 			'readonly'     => 'readonly'
// 		)
// 	), $checkout->get_value( 'delivery_date' ) );
//
// 	// Delivery Time Slot Dropdown.
// 	woocommerce_form_field( 'delivery_time_slot', array(
// 		'type'     => 'select',
// 		'class'    => array( 'delivery-time-slot-field' ),
// 		'label'    => __( 'Delivery Time Slot' ),
// 		'options'  => array( '' => __( 'Select a time slot' ) ) + $time_slots,
// 		'required' => true
// 	), $checkout->get_value( 'delivery_time_slot' ) );
//
// 	// Instant Delivery Option (if available) -- placed after the time slot field.
// 	if ( $instant_delivery['available'] ) {
// 		$instant_fee_text = __( '⚡ Instant Delivery For Today (' . $instant_delivery['current_slot'] . ') - Extra ₹5 per item' );
// 		woocommerce_form_field( 'instant_delivery', array(
// 			'type'  => 'checkbox',
// 			'class' => array( 'instant-delivery-checkbox' ),
// 			'label' => $instant_fee_text,
// 		), $checkout->get_value( 'instant_delivery' ) );
// 	}
//
// 	echo '</div>';
// 	?>
// 	<script type="text/javascript">
// 	jQuery(document).ready(function($) {
// 		// Initialize the datepicker.
// 		$("#delivery_date").datepicker({
// 			dateFormat: "yy-mm-dd",
// 			minDate: 0,
// 			maxDate: "+1d",
// 			beforeShowDay: function(date) {
// 				var currentDate = $.datepicker.formatDate('yy-mm-dd', new Date());
// 				var tomorrow = $.datepicker.formatDate('yy-mm-dd', new Date(new Date().getTime() + 24 * 60 * 60 * 1000));
// 				var dateStr = $.datepicker.formatDate('yy-mm-dd', date);
//
// 				// Only allow today and tomorrow.
// 				return [dateStr === currentDate || dateStr === tomorrow];
// 			},
// 			onSelect: function(dateText) {
// 				updateTimeSlots(dateText);
// 			}
// 		});
//
// 		// Function to update time slots based on the selected date.
// 		function updateTimeSlots(selectedDate) {
// 			// Save the current selected value.
// 			var currentSelected = $('#delivery_time_slot').val();
//
// 			$.ajax({
// 				type: 'POST',
// 				url: delivery_data.ajax_url,
// 				data: {
// 					action: 'get_delivery_slots',
// 					date: selectedDate,
// 					security: '<?php echo wp_create_nonce( 'get-delivery-slots' ); ?>'
// 				},
// 				success: function(response) {
// 					if ( response.success ) {
// 						// Clear existing options.
// 						$('#delivery_time_slot').empty();
//
// 						// Add the default option.
// 						$('#delivery_time_slot').append('<option value="">' + '<?php echo __( 'Select a time slot' ); ?>' + '</option>');
//
// 						// Add available slots.
// 						$.each(response.data, function(value, label) {
// 							$('#delivery_time_slot').append('<option value="' + value + '">' + label + '</option>');
// 						});
//
// 						// If the previous selection still exists, re-select it.
// 						if ( currentSelected && $('#delivery_time_slot option[value="' + currentSelected + '"]').length > 0 ) {
// 							$('#delivery_time_slot').val(currentSelected);
// 						}
//
// 						// Trigger change event for WooCommerce checkout update.
// 						$('#delivery_time_slot').trigger('change');
// 					}
// 				}
// 			});
// 		}
//
// 		// Handle instant delivery checkbox changes.
// 		$('#instant_delivery').change(function() {
// 			if ( $(this).is(':checked') ) {
// 				// Hide and make the date and time fields non-required.
// 				const today = new Date();
// 				const yyyy = today.getFullYear();
// 				const mm   = String(today.getMonth() + 1).padStart(2, '0');
// 				const dd   = String(today.getDate()).padStart(2, '0');
// 				const todayStr = `${yyyy}-${mm}-${dd}`;
// 				const todayStrNormal = `${dd}-${mm}-${yyyy}`
//
// 				// 2) Set the date‐picker’s value to today
// 				alert("Opted for ⚡ Instant delivery on : " +  todayStrNormal)
// 				$('#delivery_date').val(todayStr).trigger("change");
// 				$("#delivery_date_field").val(todayStr);
//
// 				// 3) Optionally, set a default timeslot if it’s a <select> or <input>
// 				$('#delivery_time_slot_field').val('');
// 				$('#delivery_time_slot').val('').trigger('change');
// 				$('#delivery_date_field, #delivery_time_slot_field').hide();
// 				$('#delivery_date, #delivery_time_slot').prop('required', false);
//
// 				// Trigger checkout update for fee recalculation.
// 				$('body').trigger('update_checkout');
// 			} else {
// 				// Show and mark the date and time fields as required.
// 				$('#delivery_date_field, #delivery_time_slot_field').show();
// 				$('#delivery_date, #delivery_time_slot').prop('required', true);
//
// 				// Trigger checkout update for fee recalculation.
// 				$('body').trigger('update_checkout');
// 			}
// 		});
//
// 		// Initialize time slots on page load if a date is already selected.
// 		if ( $('#delivery_date').val() ) {
// 			updateTimeSlots($('#delivery_date').val());
// 		}
//
// 		// Initialize instant delivery checkbox state.
// 		$('#instant_delivery').change();
// 	});
// 	</script>
// 	<?php
// }
// add_action( 'woocommerce_after_checkout_billing_form', 'add_delivery_fields' );
//
// /**
//  * AJAX handler for getting time slots.
//  */
// function get_delivery_slots_ajax() {
// 	check_ajax_referer( 'get-delivery-slots', 'security' );
//
// 	$selected_date = isset( $_POST['date'] ) ? sanitize_text_field( $_POST['date'] ) : '';
// 	if ( ! $selected_date ) {
// 		wp_send_json_error( 'No date provided' );
// 		return;
// 	}
//
// 	$slots = get_active_time_slots( $selected_date );
// 	custom_debug_log( "AJAX: Returning slots for date $selected_date: " . json_encode( $slots ) );
// 	wp_send_json_success( $slots );
// }
// add_action( 'wp_ajax_get_delivery_slots', 'get_delivery_slots_ajax' );
// add_action( 'wp_ajax_nopriv_get_delivery_slots', 'get_delivery_slots_ajax' );
//
// /**
//  * Create custom-delivery.js file if it doesn't exist.
//  */
// function ensure_custom_delivery_js() {
// 	$js_dir  = get_stylesheet_directory() . '/js';
// 	$js_file = $js_dir . '/custom-delivery.js';
//
// 	if ( ! file_exists( $js_file ) ) {
// 		if ( ! is_dir( $js_dir ) ) {
// 			mkdir( $js_dir, 0755, true );
// 		}
// 		$js_content = "
// 			// Custom Delivery JS Functions
// 			jQuery(document).ready(function($) {
// 				// This file is created automatically by functions.php.
// 				// Additional JS can be added manually here if needed.
// 			});
// 		";
// 		file_put_contents( $js_file, $js_content );
// 	}
// }
// add_action( 'after_setup_theme', 'ensure_custom_delivery_js' );
//
// /**
//  * Remove the "(optional)" text from custom field arguments.
//  */
// add_filter( 'woocommerce_form_field_args', 'custom_remove_optional_text', 10, 3 );
// function custom_remove_optional_text( $args, $key, $value ) {
// 	if ( in_array( $key, array( 'delivery_date', 'delivery_time_slot', 'instant_delivery' ) ) ) {
// 		if ( isset( $args['label'] ) ) {
// 			$args['label'] = str_replace( ' (optional)', '', $args['label'] );
// 		}
// 	}
// 	return $args;
// }
//
// /**
//  * Additional filter to remove any lingering "(optional)" text from the rendered field HTML for instant_delivery.
//  */
// add_filter( 'woocommerce_form_field', 'remove_optional_text_from_instant_delivery', 10, 4 );
// function remove_optional_text_from_instant_delivery( $field, $key, $args, $value ) {
// 	if ( 'instant_delivery' === $key ) {
// 		$field = str_replace( ' (optional)', '', $field );
// 	}
// 	return $field;
// }
//
// /**
//  * Add instant delivery fee.
//  */
// function add_instant_delivery_fee() {
// 	if ( is_admin() && ! defined( 'DOING_AJAX' ) ) {
// 		return;
// 	}
//
// 	$post_data = array();
// 	if ( isset( $_POST['post_data'] ) ) {
// 		parse_str( $_POST['post_data'], $post_data );
// 	} else {
// 		$post_data = $_POST;
// 	}
//
// 	// Check if instant delivery is selected.
// 	if ( isset( $post_data['instant_delivery'] ) && $post_data['instant_delivery'] == '1' ) {
// 		$instant_delivery = is_instant_delivery_available();
// 		if ( $instant_delivery['available'] ) {
// 			$cart_items_count = WC()->cart->get_cart_contents_count();
// 			$fee_amount       = 5 * $cart_items_count;
// 			if ( $fee_amount > 0 ) {
// 				WC()->cart->add_fee( __( 'Instant Delivery Surcharge' ), $fee_amount, true, 'standard' );
// 			}
// 		}
// 	}
// }
// add_action( 'woocommerce_cart_calculate_fees', 'add_instant_delivery_fee' );
//
// /**
//  * Validate delivery fields at checkout.
//  */
// function validate_delivery_fields() {
// 	// Skip validation if instant delivery is selected.
// 	if ( isset( $_POST['instant_delivery'] ) && $_POST['instant_delivery'] == '1' ) {
// 		return;
// 	}
//
// 	if ( empty( $_POST['delivery_date'] ) ) {
// 		wc_add_notice( __( 'Please select a delivery date' ), 'error' );
// 	}
// 	if ( empty( $_POST['delivery_time_slot'] ) ) {
// 		wc_add_notice( __( 'Please select a delivery time slot' ), 'error' );
// 	}
// }
// add_action( 'woocommerce_checkout_process', 'validate_delivery_fields' );
//
// /**
//  * Save delivery data to order meta (for standard checkout).
//  */
// function save_delivery_data_to_order( $order_id ) {
// 	if ( isset( $_POST['instant_delivery'] ) && $_POST['instant_delivery'] == '1' ) {
// 		$instant_delivery = is_instant_delivery_available();
// 		update_post_meta( $order_id, '_instant_delivery', 'yes' );
// 		update_post_meta( $order_id, '_delivery_time_slot', $instant_delivery['current_slot'] );
// 		custom_debug_log( "Order #$order_id: Instant delivery, slot: " . $instant_delivery['current_slot'] );
// 	} else {
// 		if ( ! empty( $_POST['delivery_date'] ) ) {
// 			update_post_meta( $order_id, '_delivery_date', sanitize_text_field( $_POST['delivery_date'] ) );
// 		}
// 		if ( ! empty( $_POST['delivery_time_slot'] ) ) {
// 			$time_slots = get_time_slots();
// 			$slot_key   = sanitize_text_field( $_POST['delivery_time_slot'] );
// 			$slot_label = isset( $time_slots[ $slot_key ] ) ? $time_slots[ $slot_key ] : $slot_key;
// 			update_post_meta( $order_id, '_delivery_time_slot', $slot_label );
// 		}
// 		custom_debug_log( "Order #$order_id: Regular delivery, date: " . ( isset( $_POST['delivery_date'] ) ? $_POST['delivery_date'] : 'none' ) . ", slot: " . ( isset( $_POST['delivery_time_slot'] ) ? $_POST['delivery_time_slot'] : 'none' ) );
// 	}
// }
// add_action( 'woocommerce_checkout_update_order_meta', 'save_delivery_data_to_order' );
//
// /**
//  * Save delivery data for orders created via the REST API.
//  */
// function save_delivery_data_to_order_rest( $order, $request ) {
// 	$params = $request->get_params();
// 	if ( isset( $params['instant_delivery'] ) && $params['instant_delivery'] == '1' ) {
// 		$instant_delivery = is_instant_delivery_available();
// 		$order->update_meta_data( '_instant_delivery', 'yes' );
// 		$order->update_meta_data( '_delivery_time_slot', $instant_delivery['current_slot'] );
// 		custom_debug_log( "Order (REST) #{$order->get_id()}: Instant delivery, slot: " . $instant_delivery['current_slot'] );
// 	} else {
// 		if ( isset( $params['delivery_date'] ) && ! empty( $params['delivery_date'] ) ) {
// 			$order->update_meta_data( '_delivery_date', sanitize_text_field( $params['delivery_date'] ) );
// 		}
// 		if ( isset( $params['delivery_time_slot'] ) && ! empty( $params['delivery_time_slot'] ) ) {
// 			$time_slots = get_time_slots();
// 			$slot_key   = sanitize_text_field( $params['delivery_time_slot'] );
// 			$slot_label = isset( $time_slots[ $slot_key ] ) ? $time_slots[ $slot_key ] : $slot_key;
// 			$order->update_meta_data( '_delivery_time_slot', $slot_label );
// 		}
// 		custom_debug_log( "Order (REST) #{$order->get_id()}: Regular delivery, date: " . ( isset( $params['delivery_date'] ) ? $params['delivery_date'] : 'none' ) . ", slot: " . ( isset( $params['delivery_time_slot'] ) ? $params['delivery_time_slot'] : 'none' ) );
// 	}
// 	return $order;
// }
// add_filter( 'rest_pre_insert_shop_order', 'save_delivery_data_to_order_rest', 10, 2 );
//
// /**
//  * Display delivery information on the thank you page.
//  */
// function display_delivery_info_on_thankyou( $order_id ) {
// 	$instant_delivery    = get_post_meta( $order_id, '_instant_delivery', true );
// 	$delivery_date       = get_post_meta( $order_id, '_delivery_date', true );
// 	$delivery_time_slot  = get_post_meta( $order_id, '_delivery_time_slot', true );
//
// 	echo '<section class="woocommerce-delivery-details">';
// 	echo '<h2 class="woocommerce-column__title">' . __( 'Delivery Details' ) . '</h2>';
// 	if ( $instant_delivery == 'yes' ) {
// 		echo '<p>' . __( 'Delivery Type:' ) . ' <strong>' . __( 'Instant Delivery' ) . '</strong></p>';
// 		echo '<p>' . __( 'Time Slot:' ) . ' <strong>' . esc_html( $delivery_time_slot ) . '</strong></p>';
// 	} else {
// 		echo '<p>' . __( 'Date:' ) . ' <strong>' . esc_html( $delivery_date ) . '</strong></p>';
// 		echo '<p>' . __( 'Time Slot:' ) . ' <strong>' . esc_html( $delivery_time_slot ) . '</strong></p>';
// 	}
// 	echo '</section>';
// }
// add_action( 'woocommerce_thankyou', 'display_delivery_info_on_thankyou', 10 );
//
// /**
//  * Display delivery information in the admin order page.
//  */
// function display_delivery_info_in_admin_order( $order ) {
// 	$order_id           = $order->get_id();
// 	$instant_delivery   = get_post_meta( $order_id, '_instant_delivery', true );
// 	$delivery_date      = get_post_meta( $order_id, '_delivery_date', true );
// 	$delivery_time_slot = get_post_meta( $order_id, '_delivery_time_slot', true );
//
// 	echo '<div class="order_data_column">';
// 	echo '<h4>' . __( 'Delivery Details' ) . '</h4>';
// 	if ( $instant_delivery == 'yes' ) {
// 		echo '<p><strong>' . __( 'Delivery Type:' ) . '</strong> ' . __( 'Instant Delivery' ) . '</p>';
// 		echo '<p><strong>' . __( 'Time Slot:' ) . '</strong> ' . esc_html( $delivery_time_slot ) . '</p>';
// 	} else {
// 		echo '<p><strong>' . __( 'Date:' ) . '</strong> ' . esc_html( $delivery_date ) . '</p>';
// 		echo '<p><strong>' . __( 'Time Slot:' ) . '</strong> ' . esc_html( $delivery_time_slot ) . '</p>';
// 	}
// 	echo '</div>';
// }
// add_action( 'woocommerce_admin_order_data_after_billing_address', 'display_delivery_info_in_admin_order', 10, 1 );
//
// /**
//  * Redirect non‑logged‑in users to the login page when they attempt to add a product to the cart,
//  * and save the product details (ID and quantity) in a cookie for processing after login.
//  */
// add_filter( 'woocommerce_add_to_cart_validation', 'custom_add_to_cart_validation', 10, 3 );
// function custom_add_to_cart_validation( $passed, $product_id, $quantity ) {
//     if ( ! is_user_logged_in() ) {
//         // Save product details in a cookie (expires in 5 minutes)
//         $pending_data = array(
//             'product_id' => $product_id,
//             'quantity'   => $quantity
//         );
//         setcookie( 'pending_add_to_cart', json_encode( $pending_data ), time() + 300, COOKIEPATH, COOKIE_DOMAIN );
//
//         // For AJAX requests, return a JSON response with a redirect URL.
//         if ( wp_doing_ajax() ) {
//             wp_send_json( array(
//                 'error'    => true,
//                 'redirect' => site_url( '/login' )
//             ) );
//             wp_die();
//         } else {
//             // For non-AJAX requests, perform a safe redirect.
//             wp_safe_redirect( site_url( '/login' ) );
//             exit;
//         }
//     }
//
//     return $passed;
// }
//
// /*
//  * After login, check if a pending product exists (saved in a cookie)
//  * and automatically add it to the cart.
//  */
// /*
// add_action( 'init', 'process_pending_add_to_cart' );
// function process_pending_add_to_cart() {
//     if ( is_user_logged_in() && isset( $_COOKIE['pending_add_to_cart'] ) ) {
//         $pending = json_decode( stripslashes( $_COOKIE['pending_add_to_cart'] ), true );
//         if ( ! empty( $pending['product_id'] ) ) {
//             WC()->cart->add_to_cart( absint( $pending['product_id'] ), absint( $pending['quantity'] ) );
//         }
//         // Clear the cookie so that the pending item is processed only once.
//         setcookie( 'pending_add_to_cart', '', time() - 3600, COOKIEPATH, COOKIE_DOMAIN );
//         unset( $_COOKIE['pending_add_to_cart'] );
//     }
// }
// */
//
// function custom_update_display_name($user_id) {
//     if (isset($_POST['account_display_name']) && !empty($_POST['account_display_name'])) {
//         $display_name = sanitize_text_field($_POST['account_display_name']);
//
//         // Update user display name
//         wp_update_user(array(
//             'ID' => $user_id,
//             'display_name' => $display_name,
//             'nickname' => $display_name
//         ));
//     }
// }
// add_action('woocommerce_save_account_details', 'custom_update_display_name');
//
// // Register the custom endpoint
// add_action('rest_api_init', function () {
//     register_rest_route('custom-api/v1', '/orders-by-delivery-date', [
//         'methods'  => 'GET',
//         'callback' => 'get_orders_by_custom_delivery_date',
//         'permission_callback' => function () {
//             // Ensure authenticated user can read orders
//             return true;
//         },
//     ]);
// });
//
//
// add_action('rest_api_init', 'register_custom_woocommerce_endpoints');
//
// function register_custom_woocommerce_endpoints() {
// 	register_rest_route('wc/v3', '/custom-data19', array(
// 	'methods' => 'GET',
// 	'callback' => 'get_orders_by_custom_delivery_date',
// 	'permission_callback' => '__return_true',
// ));
// }
//
//
// // Callback function for the endpoint
// function get_orders_by_custom_delivery_date($request) {
//     $after  = $request->get_param('after');
//     $before = $request->get_param('before');
//
//     $meta_query = [
//     'relation' => 'AND',
// 	];
//
//     // Add after filter
//     if ($after) {
//         $meta_query[] = [
//             'key'     => '_delivery_date',
//             'value'   => $after,
//             'compare' => '>=',
//             'type'    => 'DATE',
//         ];
//     }
//
//     // Add before filter
//     if ($before) {
//         $meta_query[] = [
//             'key'     => '_delivery_date',
//             'value'   => $before,
//             'compare' => '<=',
//             'type'    => 'DATE',
//         ];
//     }
//
//     // Query WooCommerce orders
//     $args = [
//         'limit'      => -1,        // return all matching orders
//         'status'     => 'any',     // include all order statuses
//          'meta_query' => $meta_query,
//     ];
//
//     $orders = wc_get_orders($args);
//     $results = [];
//
//     foreach ($orders as $order) {
//         // You must use WC_Order methods, not get_data()
//         $order_data = [
//             'id'           => $order->get_id(),
//             'status'       => $order->get_status(),
//             'total'        => $order->get_total(),
//             'customer_id'  => $order->get_customer_id(),
//             'currency'     => $order->get_currency(),
//             'payment_method' => $order->get_payment_method(),
//             'date_created' => $order->get_date_created() ? $order->get_date_created()->date('Y-m-d H:i:s') : null,
//             'billing_email' => $order->get_billing_email(),
//             'delivery_date' => get_post_meta($order->get_id(), '_delivery_date', true),
// 			'delivery_time_slot' => get_post_meta($order->get_id(), '_delivery_time_slot', true),
//
//         ];
//
//         $results[] = $order_data;
//     }
//
//     return new WP_REST_Response($results, 200);
// }
// add_action('wp_enqueue_scripts', function () {
//     if (!wp_script_is('jquery', 'enqueued')) {
//         wp_enqueue_script('jquery');
//     }
// });
// function restrict_products_for_unserviceable_areas($query) {
//   if (!is_admin() && $query->is_main_query() && (is_shop() || is_product_category() || is_product_tag())) {
//     if (isset($_COOKIE['user_area'])) {
//       $user_area = sanitize_text_field($_COOKIE['user_area']);
//
//       // Define unserviceable areas
//       $unserviceable_areas = array('GM Palya');
//
//       if (in_array($user_area, $unserviceable_areas)) {
//         // Hide all products by forcing empty result
//         $query->set('post__in', array(0));
//       }
//     }
//   }
// }
// add_action('pre_get_posts', 'restrict_products_for_unserviceable_areas');
// function show_area_restriction_notice() {
//   if (is_shop() || is_product_category()) {
//     $user_area = isset($_COOKIE['user_area']) ? sanitize_text_field($_COOKIE['user_area']) : '';
//     $unserviceable_areas = array('GM Palya');
//
//     if (in_array($user_area, $unserviceable_areas)) {
//       echo '<div class="woocommerce-info" style="text-align:center;">
//               We are expanding! Products are not yet available in your area.
//             </div>';
//     }
//   }
// }
// add_action('woocommerce_before_main_content', 'show_area_restriction_notice');
//
//
//
// // 1. Add custom field
// add_filter('woocommerce_checkout_fields', 'custom_add_checkout_field');
//
// function custom_add_checkout_field($fields) {
//     $fields['billing']['custom_order_note'] = array(
//         'type'        => 'text',
//         'label'       => __('Custom Order Note'),
//         'placeholder' => __('Add your message here'),
//         'required'    => false,
//         'class'       => array('form-row-wide'),
//         'priority'    => 25,
//     );
//     return $fields;
// }
//
// // 2. Save the field value
// add_action('woocommerce_checkout_update_order_meta', 'custom_save_checkout_field');
//
// function custom_save_checkout_field($order_id) {
//     if (!empty($_POST['custom_order_note'])) {
//         update_post_meta($order_id, 'custom_order_note', sanitize_text_field($_POST['custom_order_note']));
//     }
// }
//
// // 3. Display in Admin order page
// add_action('woocommerce_admin_order_data_after_billing_address', 'custom_display_admin_order_meta', 10, 1);
//
// function custom_display_admin_order_meta($order) {
//     $note = get_post_meta($order->get_id(), 'custom_order_note', true);
//     if ($note) {
//         echo '<p><strong>' . __('Custom Order Note') . ':</strong> ' . esc_html($note) . '</p>';
//     }
// }
//
//
// /* ======================================================================
//    ADDITIONAL CHECKOUT FUNCTIONALITY - FLOOR SELECTION FEE
//    ====================================================================== */
//
// // 1. Add floor selection field to checkout
// add_action('woocommerce_after_order_notes', 'add_floor_selection_field');
// function add_floor_selection_field($checkout) {
//     echo '<div id="floor_selection_field" style="margin-top:20px;">';
//     echo '<h3>' . __('Delivery Floor') . '</h3>';
//
//     woocommerce_form_field('delivery_floor', array(
//         'type'        => 'select',
//         'class'       => array('floor-selection-field'),
//         'label'       => __('Select your floor'),
//         'required'    => true,
//         'options'     => array(
//             '0'       => __('Ground floor or lift available (No extra charge)'),
//             '1'       => __('1st floor (+₹5)'),
//             '2'       => __('2nd floor (+₹5)'),
//             '3'       => __('3rd floor (+₹5)')
//         ),
//         'default'     => '0'
//     ), $checkout->get_value('delivery_floor'));
//
//     echo '</div>';
// }
//
// // 2. Add floor fee based on selection
// add_action('woocommerce_cart_calculate_fees', 'add_floor_fee');
// function add_floor_fee() {
//     if (is_admin() && !defined('DOING_AJAX')) {
//         return;
//     }
//
//     // Get floor selection from POST data
//     $post_data = array();
//     if (isset($_POST['post_data'])) {
//         parse_str($_POST['post_data'], $post_data);
//     } else {
//         $post_data = $_POST;
//     }
//
//     if (isset($post_data['delivery_floor']) && $post_data['delivery_floor'] != '0') {
//         $floor_fee = 5;
//         WC()->cart->add_fee(__('Floor delivery charge'), $floor_fee, false, 'standard');
//     }
// }
//
// // 3. Save floor selection to order meta
// add_action('woocommerce_checkout_update_order_meta', 'save_floor_selection');
// function save_floor_selection($order_id) {
//     if (!empty($_POST['delivery_floor'])) {
//         update_post_meta($order_id, '_delivery_floor', sanitize_text_field($_POST['delivery_floor']));
//     }
// }
//
// // 4. Display floor selection in admin and emails
// add_action('woocommerce_admin_order_data_after_shipping_address', 'display_floor_selection_admin', 10, 1);
// function display_floor_selection_admin($order) {
//     $floor = get_post_meta($order->get_id(), '_delivery_floor', true);
//     if ($floor) {
//         $floor_options = array(
//             '0' => 'Ground floor or lift available',
//             '1' => '1st floor',
//             '2' => '2nd floor',
//             '3' => '3rd floor'
//         );
//         echo '<p><strong>' . __('Delivery Floor:') . '</strong> ' . $floor_options[$floor] . '</p>';
//     }
// }
//
//
// /* ======================================================================
//    ADD FLOOR SELECTION TO REST API ORDERS
//    ====================================================================== */
// add_filter('woocommerce_rest_prepare_shop_order_object', 'add_floor_to_api_response', 10, 3);
// function add_floor_to_api_response($response, $order, $request) {
//     $floor = get_post_meta($order->get_id(), '_delivery_floor', true);
//     if (!empty($floor)) {
//         $response->data['delivery_floor'] = $floor;
//     }
//     return $response;
// }
//
// /* ======================================================================
//    STYLE THE FLOOR SELECTION FIELD
//    ====================================================================== */
// add_action('wp_head', 'add_floor_selection_styles');
// function add_floor_selection_styles() {
//     if (is_checkout()) {
//         ?>
//         <style>
//             #floor_selection_field {
//                 margin-bottom: 20px;
//                 padding: 15px;
//                 border: 1px solid #e0e0e0;
//                 border-radius: 5px;
//             }
//             .floor-selection-field select {
//                 padding: 10px;
//                 width: 100%;
//                 border: 1px solid #ddd;
//                 border-radius: 4px;
//             }
//             .support-contact a {
//                 color: #333;
//                 text-decoration: none;
//             }
//             .support-contact a:hover {
//                 color: #0073aa;
//             }
//         </style>
//         <?php
//     }
// }
//
//
//
// /* ======================================================================
//    ADD SUPPORT NUMBER TO MY ORDERS PAGE
//    ====================================================================== */
// add_action('woocommerce_order_details_after_order_table', 'add_support_number_to_my_orders');
// function add_support_number_to_my_orders($order) {
//     echo '<div class="customer-support-box" style="margin:30px 0; padding:20px; background:#f8f8f8; border-radius:8px; border:1px solid #e5e5e5;">';
//     echo '<h3 style="margin-top:0; color:#333;">' . __('Need Help?', 'woocommerce') . '</h3>';
//     echo '<p style="margin-bottom:10px;">' . __('For any questions about your order, contact our support team:', 'woocommerce') . '</p>';
//     echo '<div style="display:flex; align-items:center; gap:10px;">';
//     echo '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#0073aa" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>';
//     echo '<a href="tel:+919986776655" style="font-weight:bold; color:#0073aa; text-decoration:none; font-size:16px;">+91 99867 76655</a>';
//     echo '</div>';
//     echo '<p style="margin-top:10px; font-size:14px; color:#666;">' . __('Available 9AM - 9PM, 7 days a week', 'woocommerce') . '</p>';
//     echo '</div>';
// }
//
// /* ======================================================================
//    ADD ITEM COUNT TO FLOATING CART BUTTON - FIXED IMPLEMENTATION
//    ====================================================================== */
// add_action('wp_footer', 'add_cart_count_to_floating_button', 99);
// function add_cart_count_to_floating_button() {
//     if (!is_admin() && !wp_doing_ajax() && function_exists('WC')) {
//         $cart_count = WC()->cart->get_cart_contents_count();
//         ?>
//         <script type="text/javascript">
//         jQuery(document).ready(function($) {
//             // More reliable way to find the floating cart button
//             function findFloatingCartButton() {
//                 // Try common selectors used in themes
//                 var selectors = [
//                     '.aux-action-button-cart', // Auxin theme
//                     '.floating-cart-btn',
//                     '.floating-cart',
//                     '.aux-cart-floater',
//                     '.et-cart-info', // Divi theme
//                     '.cart-contents', // Many themes
//                     '.wcmenucart-contents' // WooCommerce menu cart
//                 ];
//
//                 for (var i = 0; i < selectors.length; i++) {
//                     var $button = $(selectors[i]);
//                     if ($button.length && ($button.css('position') === 'fixed' || $button.parent().css('position') === 'fixed')) {
//                         return $button;
//                     }
//                 }
//
//                 // Fallback: Any cart link in fixed position
//                 return $('a[href*="cart"]').filter(function() {
//                     return $(this).css('position') === 'fixed' || $(this).parent().css('position') === 'fixed';
//                 }).first();
//             }
//
//             var $floatingButton = findFloatingCartButton();
//
//             if ($floatingButton.length) {
//                 // Create the count badge if it doesn't exist
//                 if (!$floatingButton.find('.floating-cart-count').length) {
//                     $floatingButton.append(
//                         '<span class="floating-cart-count" style="' +
//                         'position:absolute; top:0px; right:0px; ' +
//                         'background:#ff0000; color:#fff; border-radius:50%; ' +
//                         'min-width:18px; height:18px; display:flex; ' +
//                         'align-items:center; justify-content:center; ' +
//                         'font-size:11px; font-weight:bold; padding:0 3px; ' +
//                         'line-height:1; border:2px solid #fff; z-index:100;">' +
//                         <?php echo $cart_count; ?> +
//                         '</span>'
//                     );
//                 }
//
//                 // Update cart count function
//                 function updateCartCount() {
//                     $.ajax({
//                         url: wc_add_to_cart_params.ajax_url,
//                         data: {
//                             action: 'get_cart_count'
//                         },
//                         success: function(response) {
//                             if (response.count !== undefined) {
//                                 $floatingButton.find('.floating-cart-count').text(response.count);
//                                 $floatingButton.find('.floating-cart-count').toggle(response.count > 0);
//                             }
//                         }
//                     });
//                 }
//
//                 // Initial update
//                 updateCartCount();
//
//                 // Update when cart changes
//                 $(document.body).on('added_to_cart removed_from_cart updated_wc_div updated_cart_totals', function() {
//                     updateCartCount();
//                 });
//             }
//         });
//         </script>
//         <style>
//             .floating-cart-count {
//                 animation: pulse 1.5s infinite;
//             }
//             @keyframes pulse {
//                 0% { transform: scale(1); }
//                 50% { transform: scale(1.1); }
//                 100% { transform: scale(1); }
//             }
//         </style>
//         <?php
//     }
// }
//
// /* ======================================================================
//    AJAX ENDPOINT FOR CART COUNT
//    ====================================================================== */
// add_action('wp_ajax_get_cart_count', 'get_cart_count_ajax');
// add_action('wp_ajax_nopriv_get_cart_count', 'get_cart_count_ajax');
// function get_cart_count_ajax() {
//     wp_send_json(array(
//         'count' => WC()->cart->get_cart_contents_count()
//     ));
// }
//
// /* ======================================================================
//    ENSURE CART SCRIPTS ARE LOADED
//    ====================================================================== */
// add_action('wp_enqueue_scripts', 'ensure_cart_script_dependencies');
// function ensure_cart_script_dependencies() {
//     if (!is_admin() && function_exists('WC')) {
//         wp_enqueue_script('wc-cart');
//     }
// }